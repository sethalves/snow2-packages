(define-library (seth snow2 manage)
  (export make-package-archives
          upload-packages-to-s3
          check-packages
          )

  (import (scheme base)
          (scheme read)
          (scheme write)
          (scheme file)
          (scheme time)
          (scheme process-context))
  (cond-expand
   (chibi (import (only (srfi 1) filter make-list any
                        fold last lset-difference delete-duplicates
                        drop-right)))
   (else (import (srfi 1))))
  (import (snow snowlib)
          (snow tar)
          (snow zlib)
          (snow filesys)
          (snow srfi-13-strings)
          (snow extio)
          (seth uri)
          (seth crypt md5)
          (seth aws common)
          (seth aws s3)
          (seth snow2 types)
          (seth snow2 utils))

  (begin



    (define (make-package-archive local-repository package)
      (let* ((repo-path (uri-path (snow2-repository-url local-repository))))

        (define (lib-file->tar-recs lib-filename)
          ;; create a tar-rec for a file
          (let* ((lib-rel-path (snow-split-filename lib-filename))
                 (lib-full-path (append repo-path lib-rel-path))
                 (lib-full-filename (snow-combine-filename-parts lib-full-path))
                 (tar-recs (tar-read-file lib-full-filename)))
            (cond ((not (= (length tar-recs) 1))
                   (error "unexpected tar-rec count" lib-filename tar-recs)))
            (tar-rec-name-set! (car tar-recs) lib-filename)
            (car tar-recs)))

        (define (lib-dir->tar-recs lib-dirname)
          ;; create a tar-rec for a directory
          (let* ((lib-rel-path (snow-split-filename lib-dirname))
                 (tar-rec
                  (make-tar-rec
                   (snow-combine-filename-parts
                    (append lib-rel-path (list "")))
                   493 ;; mode
                   0 ;; uid
                   0 ;; gid
                   (exact (floor (current-second))) ;; mtime
                   'directory
                   "" ;; linkname
                   "root" ;; uname
                   "root" ;; gname
                   0 ;; devmajor
                   0 ;; devminor
                   #f ;; atime
                   #f ;; ctime
                   (make-bytevector 0))))
            (list tar-rec)))

        (define (file->directories filename)
          ;; given a relative filename, return a list of directory
          ;; paths.  if filename is "a/b/c", return '("a/" "a/b/")
          (let loop ((parts (drop-right (snow-split-filename filename) 1))
                     (result '()))
            (cond ((null? parts)
                   (map snow-combine-filename-parts result))
                  (else
                   (loop (drop-right parts 1)
                         (cons parts result))))))

        (define (manifest->directories manifest)
          ;; product a list of directories needed in order to hold
          ;; all the files listed in manifest.
          (delete-duplicates
           (fold append '() (map file->directories manifest))
           equal?))

        (let* ((libraries (snow2-package-libraries package))
               ;; get a list of filenames for all libraries in the package
               (manifest (fold append '() (map get-library-manifest libraries)))
               ;; get a list of directories needed to hold the library files
               (dirs (manifest->directories manifest))
               ;; make tar records for the directories
               (dir-tar-recs (fold append '() (map lib-dir->tar-recs dirs)))
               ;; make tar records for the files
               (file-tar-recs (map lib-file->tar-recs manifest))
               ;; combine them
               (all-tar-recs (append dir-tar-recs file-tar-recs))
               ;; figure out the name of the tgz file within the local repo
               (package-url (snow2-package-url package))
               (package-filename (last (uri-path package-url)))
               (local-package-path (append repo-path (list package-filename)))
               (local-package-filename
                (snow-combine-filename-parts local-package-path)))
          (display "writing ")
          (display local-package-path)
          (newline)

          (cond ((or (snow-file-exists? local-package-filename)
                     (snow-file-symbolic-link? local-package-filename))
                 (snow-delete-file local-package-filename)))

          (let* ((tar-data (tar-pack-u8vector all-tar-recs))
                 (tgz-data (gzip-u8vector tar-data))
                 (out-p (open-binary-output-file local-package-filename)))

            (write-bytevector tgz-data out-p)
            (close-output-port out-p)))))


    (define (conditional-put-object! credentials bucket s3-path local-filename)
      (let ((local-md5 (filename->md5 local-filename))
            (local-p (open-binary-input-file local-filename))
            (md5-on-s3 (get-object-md5 credentials bucket s3-path)))

        ;; (display "local-md5=") (write local-md5) (newline)
        ;; (display "md5-on-s3=") (write md5-on-s3) (newline)

        (cond ((equal? md5-on-s3 local-md5)
               (display "[")
               (write local-filename)
               (display " unchanged]\n"))
              (else
               (display "[")
               (write local-filename)
               (display " --> s3:")
               (display bucket)
               (display s3-path)
               (display "]")
               (newline)
               (snow-with-exception-catcher
                (lambda (err)
                  (snow-display-error err)
                  (exit 1))
                (lambda ()
                  (put-object! credentials bucket s3-path local-p
                               #f ;; (snow-file-size local-filename)
                               "application/octet-stream"
                               'public-read)
                  ))
               (close-input-port local-p)))))


    (define (upload-package-to-s3 credentials local-repository package)
      (let* ((repo-path (uri-path (snow2-repository-url local-repository)))
             (url (snow2-package-url package))
             (local-package-path (reverse
                                  (cons (last (uri-path url))
                                        (reverse repo-path))))
             (local-package-filename (snow-combine-filename-parts
                                      local-package-path))
             (local-package-port
              (open-binary-input-file local-package-filename))
             (bucket (uri->bucket url))
             (s3-path (uri->path-string url))
             (credentials (if credentials credentials
                              (get-credentials-for-s3-bucket bucket))))
        (conditional-put-object!
         credentials bucket s3-path local-package-filename)
        (close-input-port local-package-port)))


    (define (find-implied-local-repository)
      (or
       (get-repository
        (uri-reference (snow-combine-filename-parts '("."))))
       (get-repository
        (uri-reference (snow-combine-filename-parts '(".."))))
       (get-repository
        (uri-reference (snow-combine-filename-parts '(".." ".."))))
       (get-repository
        (uri-reference (snow-combine-filename-parts '(".." ".." ".."))))
       (get-repository
        (uri-reference (snow-combine-filename-parts '(".." ".." ".." ".."))))))


    (define (all-package-files local-repository)
      ;; return a list of package-file filenames for the given
      ;; local repository
      (let* ((repo-path (uri-path (snow2-repository-url local-repository)))
             (repo-dirname (snow-combine-filename-parts repo-path))
             (packages-dirname (snow-make-filename repo-dirname "packages")))
        (map (lambda (package-filename)
               (snow-make-filename packages-dirname package-filename))
             (snow-directory-files packages-dirname))))


    (define (resolve-package-file local-repository package-file)
      ;; package-files may be a path (absolute or relative) to
      ;; a repo/packages/NAME.package file, or they may be
      ;; just NAME.  either way, return the former.
      (cond ((string-suffix? ".package" package-file) package-file)
            (else
             (let* ((repo-uri (snow2-repository-url local-repository))
                    (repo-path (uri-path repo-uri)))
               (snow-combine-filename-parts
                (append repo-path
                        (list "packages"
                              (string-append package-file ".package"))))))))



    (define (resolve-package-files local-repository package-files)
      ;; call resolve-package-file for each of package-files
      (map (lambda (package-file)
             (resolve-package-file local-repository package-file))
           package-files))


    (define (find-implied-local-package-files local-repository)
      ;; look at the current working directory and see if
      ;; the user intends to operate on a specific package in the
      ;; repository, or on all of them.
      (let* ((repo-path (uri-path (snow2-repository-url local-repository)))
             (cwd (get-environment-variable "PWD"))
             (cwd-parts (snow-split-filename cwd))
             (cwd-parts-len (length cwd-parts))
             (cwd-from-end
              (lambda (n)
                (and (> cwd-parts-len n)
                     (list-ref cwd-parts (- cwd-parts-len n))))))
        (cond
         ;; are we in the tests directory?
         ((equal? "tests" (cwd-from-end 1))
          ;; (display "in test directory...\n")
          (all-package-files local-repository))
         ;; are we in a specific test directory?
         ((and (equal? "tests" (cwd-from-end 2))
               (let ((package-filename
                      (snow-combine-filename-parts
                       (append
                        repo-path
                        (list "packages")
                        (list (string-append (cwd-from-end 1) ".package"))))))
                 (if (snow-file-exists? package-filename)
                     package-filename
                     #f))) =>
                     (lambda (package-filename)
                       ;; (display "in specific test directory...\n")
                       (list package-filename)))
         ;; are we in the packages directory?
         ((equal? "packages" (cwd-from-end 1))
          ;; (display "in packages directory...\n")
          (all-package-files local-repository))
         (else
          ;; (display "don't know...\n")
          (all-package-files local-repository)))))


    (define (local-repository-operation repositories op)
      ;; decide which local repository is intended.
      ;; call (op local-repository)
      (let ((repositories (filter snow2-repository-local repositories)))
        (let ((repository
               (cond ((> (length repositories) 1)
                      (error "multiple local repositories given.\n"))
                     ((= (length repositories) 1)
                      (car repositories))
                     (else (find-implied-local-repository)))))
          ;; (display "operating on repository: ")
          ;; (write (uri-path (snow2-repository-url repository)))
          ;; (newline)
          (op repository))))


    (define (local-packages-operation repositories package-files op)
      ;; decide which local repository is intended.
      ;; call (op local-repo package) for each package-file.
      ;; return a list of results.
      (local-repository-operation
       repositories
       (lambda (local-repository)
         (let* ((package-files
                 (cond ((pair? package-files) package-files)
                       (else (find-implied-local-package-files
                              local-repository))))
                (repo-path (uri-path (snow2-repository-url local-repository)))
                (index-filename (snow-combine-filename-parts
                                 (append repo-path (list "index.scm"))))
                (package-files
                 (resolve-package-files local-repository package-files))
                (result
                 (map
                  (lambda (package-filename)

                    ;; (display "operating on package: ")
                    ;; (write package-filename)
                    ;; (newline)

                    (let* ((package
                            ;; (package-from-filename package-filename)
                            (refresh-package-from-filename
                             local-repository package-filename))
                           (result (op local-repository
                                       package-filename
                                       package)))
                      ;; rewrite package file to sync any changes
                      (let ((p (open-output-file package-filename)))
                        (snow-pretty-print (package->sexp package) p)
                        (close-output-port p))
                      result))
                  package-files)))
           (let ((p (open-output-file index-filename)))
             (snow-pretty-print (repository->sexp local-repository) p)
             (close-output-port p))
           result))))


    (define (make-package-archives repositories package-files)
      ;; call make-package-archive for each of packages-files
      (local-packages-operation
       repositories package-files
       (lambda (local-repository package-filename package)
         (make-package-archive local-repository package))))

    (define (list-replace-last lst new-elt)
      ;; what's the srfi-1 one-liner for this?
      (reverse (cons new-elt (cdr (reverse lst)))))


    (define (upload-packages-to-s3 credentials repositories package-files)
      (local-packages-operation
       repositories package-files
       (lambda (local-repository package-filename package)
         (upload-package-to-s3 credentials local-repository package)
         (let* ((package-uri (snow2-package-url package))
                (package-path (uri-path package-uri))
                (index-path (list-replace-last package-path "index.scm"))
                (index-uri (update-uri package-uri 'path index-path))
                (index-bucket (uri->bucket index-uri))
                (index-s3-path (uri->path-string index-uri))
                (repo-path (uri-path (snow2-repository-url local-repository)))
                (index-filename (snow-combine-filename-parts
                                 (append repo-path (list "index.scm"))))
                (credentials (if credentials credentials
                                 (get-credentials-for-s3-bucket index-bucket)))
                )
           ;; (display "index-filename=")
           ;; (write index-filename)
           ;; (newline)
           ;; (display "index-uri=")
           ;; (write (uri->string index-uri))
           ;; (newline)
           ;; (display "index-bucket=")
           ;; (write index-bucket)
           ;; (newline)
           ;; (display "index-s3-path=")
           ;; (write index-s3-path)
           ;; (newline)

           (conditional-put-object! credentials index-bucket
                                    index-s3-path index-filename)
           )
         )))


    (define (r7rs-explode-cond-expand r7rs-lib)
      (let loop ((r7rs-lib r7rs-lib)
                 (result '()))
        (cond ((null? r7rs-lib) result)
              (else
               (let ((term (car r7rs-lib)))
                 (cond ((and (pair? term)
                             (eq? (car term) 'cond-expand))
                        (let* ((ce-terms (cdr term))
                               (childs (map cdr ce-terms))
                               (childs-flat (apply append childs)))
                          (loop (cdr r7rs-lib) (append result childs-flat))))
                       (else
                        (loop (cdr r7rs-lib)
                              (append result (list term))))))))))


    (define (r7rs-drop-body r7rs-lib)
      (filter
       (lambda (term)
         (not (and (pair? term) (eq? (car term) 'begin))))
       r7rs-lib))


    (define (r7rs-extract-im/export r7rs-lib type)
      (let loop ((r7rs-lib r7rs-lib)
                 (result '()))
        (cond ((null? r7rs-lib) result)
              (else
               (let ((term (car r7rs-lib)))
                 (cond ((and (pair? term) (eq? (car term) type))
                        (let ((childs (cdr term)))
                          (loop (cdr r7rs-lib) (append result childs))))
                       (else
                        (loop (cdr r7rs-lib) result))))))))

    (define (uniq lst)
      (cond ((null? lst) lst)
            ((member (car lst) (cdr lst)) (uniq (cdr lst)))
            (else (cons (car lst) (uniq (cdr lst))))))


    (define (r7rs-filter-known-imports r7rs-imports)
      (filter
       (lambda (r7rs-import)
         (cond ((memq (car r7rs-import)
                      '(scheme scheme chibi r7rs gauche sagittarius
                               ports tcp rnrs use openssl udp posix
                               srfi chicken ssax sxml sxpath txpath
                               sxpath-lolevel text md5 rfc math sha1 sha2
                               util memcached matchable match
                               extras http-client uri-generic intarweb
                               message-digest file z3 base64 hmac
                               binary input-parse

                               srfi-27 srfi-95
                               )) #f)
               (else #t)))
       r7rs-imports))


    (define (r7rs-get-library-imports filename)
      ;; (display filename)
      ;; (newline)

      (let* ((p (open-input-file filename))
             (r7rs-lib (read p))
             (r7rs-no-begin (r7rs-drop-body r7rs-lib))
             (r7rs-sans-ce (r7rs-explode-cond-expand r7rs-no-begin))
             (r7rs-imports-all (r7rs-extract-im/export r7rs-sans-ce 'import))
             (r7rs-imports-clean
              (map (lambda (r7rs-import)
                     (cond ((eq? (car r7rs-import) 'only)
                            (cadr r7rs-import))
                           ((eq? (car r7rs-import) 'prefix)
                            (cadr r7rs-import))
                           (else r7rs-import)))
                   r7rs-imports-all))
             (r7rs-imports (r7rs-filter-known-imports
                            (uniq r7rs-imports-clean))))
        (close-input-port p)

        ;; (snow-pretty-print r7rs-no-begin)
        ;; (newline)
        ;; (snow-pretty-print r7rs-sans-ce)
        ;; (newline)
        ;; (newline)
        ;; (snow-pretty-print r7rs-imports)
        ;; (newline)
        ;; (snow-pretty-print r7rs-imports)
        ;; (newline)

        r7rs-imports))


    (define (check-packages credentials repositories package-files)
      (local-packages-operation
       repositories package-files
       (lambda (local-repository package-filename package)
         (let ((repo-path (uri-path (snow2-repository-url local-repository))))
           (map
            (lambda (lib)
              (let* ((lib-filename (snow2-library-path lib))
                     (lib-path
                      (append repo-path (snow-split-filename lib-filename)))
                     (lib-filename (snow-combine-filename-parts lib-path))
                     (lib-imports (r7rs-get-library-imports lib-filename))
                     (pkg-depends (snow2-library-depends lib))
                     (deps-missing
                      (lset-difference equal? lib-imports pkg-depends))
                     (deps-unneeded
                      (lset-difference equal? pkg-depends lib-imports))
                     )

                ;; (display "------lib imports----------\n")
                ;; (write lib-imports)
                ;; (newline)
                ;; (display "------pkg-depends----------\n")
                ;; (write pkg-depends)
                ;; (newline)

                (cond
                 ((pair? deps-missing)
                  (display "library ")
                  (write (snow2-library-name lib))
                  (display " in ")
                  (write package-filename)
                  (display " is missing depends: ")
                  (write deps-missing)
                  (newline)))

                (cond
                 ((pair? deps-unneeded)
                  (display "library ")
                  (write (snow2-library-name lib))
                  (display " in ")
                  (write package-filename)
                  (display " has unneeded depends: ")
                  (write deps-unneeded)
                  (newline)))

                ))
            (snow2-package-libraries package))))))

    ))
