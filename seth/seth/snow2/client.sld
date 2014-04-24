(define-library (seth snow2 client)
  (export install
          uninstall
          client
          main-program)

  (import (scheme base) (scheme read) (scheme write)
          (scheme file) (scheme process-context))
  (cond-expand
   (chibi (import (only (srfi 1) filter make-list any fold)))
   (else (import (srfi 1))))
  (cond-expand
   (chibi (import (chibi filesystem)))
   (else))
  (import (snow snowlib)
          (snow extio)
          (snow srfi-13-strings)
          (seth srfi-69-hash-tables)
          (snow filesys) (snow binio) (snow genport) (snow zlib) (snow tar)
          (prefix (seth http) http-)
          (seth temporary-file)
          (seth string-read-write)
          (seth srfi-37-argument-processor)
          (seth uri)
          (seth snow2 types)
          (seth snow2 utils)
          (seth snow2 manage)
          )
  (begin

    (define (write-tar-recs-to-disk tar-recs)
      (let loop ((tar-recs tar-recs))
        (cond ((null? tar-recs) #t)
              (else
               (let ((t (car tar-recs)))
                 (cond
                  ((eq? (tar-rec-type t) 'directory)
                   (snow-create-directory-recursive
                    (tar-rec-name t)))
                  ((eq? (tar-rec-type t) 'regular)
                   (cond ((or (snow-file-symbolic-link? (tar-rec-name t))
                              (snow-file-directory? (tar-rec-name t)))
                          (display "not overwriting " (current-error-port))
                          (display (tar-rec-name t) (current-error-port))
                          (newline (current-error-port)))
                         (else
                          (let ((hndl (binio-open-output-file
                                       (tar-rec-name t))))
                            (binio-write-subu8vector
                             (tar-rec-content t) 0
                             (bytevector-length (tar-rec-content t)) hndl)))))
                  (else
                   (error "unexpected file type in tar file")))
                 (loop (cdr tar-recs)))))))

    (define (install repositories library-names use-symlinks verbose)
      ;; this is the main interface point for downloading/finding and
      ;; unpacking packages.  repositories is a list of repository records.
      ;; library-names is a list of library-name s-expressions.
      ;; use-symlinks being true will cause symlinks to source files rather
      ;; than copies (when possible).  verbose prints more.
      (define (install-from-tgz repo local-package-filename)
        (snow-with-exception-catcher
         (lambda (err)
           (display "Error -- " (current-error-port))
           (display local-package-filename (current-error-port))
           (display " " (current-error-port))
           (cond
            ((snow-error-condition? err)
             (display (snow-error-condition-msg err) (current-error-port)))
            (else
             (display err)))
           (newline (current-error-port))
           #f)
         (lambda ()
           (let* ((bin-port (binio-open-input-file
                             local-package-filename))
                  (zipped-p (genport-native-input-port->genport bin-port))
                  (unzipped-p (gunzip-genport zipped-p))
                  (tar-recs (tar-unpack-genport unzipped-p)))
             (genport-close-input-port unzipped-p)
             (write-tar-recs-to-disk tar-recs)))))


      (define (install-from-http repo package url)
        (let-values (((write-port local-package-filename)
                      (temporary-file)))
          (display "downloading ")
          (display (snow-filename-strip-directory (uri->string url)))
          (display " from ")
          (display (uri->string (snow2-repository-url repo)))
          (newline)

          (let ((download-success
                 (snow-with-exception-catcher
                  (lambda (exn)
                    (display "unable to install package: "
                             (current-error-port))
                    (display (uri->string url) (current-error-port))
                    (newline (current-error-port))
                    (display exn (current-error-port))
                    (newline (current-error-port))
                    #f)
                  (lambda ()
                    (http-download-file (uri->string url) write-port)))))

            (cond (download-success
                   (let ((success
                          (install-from-tgz repo local-package-filename)))
                     (delete-file local-package-filename)
                     success))
                  (else #f)))))


      (define (install-symlinks repo package)
        (let* ((libraries (snow2-package-libraries package))
               (manifest (fold append '() (map get-library-manifest libraries)))
               (repo-path (uri-path (snow2-repository-url repo))))
          (for-each
           (lambda (library-member-filename)
             (let* ((dst-path (snow-split-filename library-member-filename))
                    (dst-filename (snow-combine-filename-parts dst-path))
                    (dst-dir-path (reverse (cdr (reverse dst-path))))
                    (dst-dirname (snow-combine-filename-parts dst-dir-path))
                    (src-path (append repo-path dst-path))
                    (src-filename (snow-combine-filename-parts src-path)))

             ;; (display "src-path=") (write src-path) (newline)
             ;; (display "src-filename=") (write src-filename) (newline)
             ;; (display "dst-path=") (write dst-path) (newline)
             ;; (display "dst-filename=") (write dst-filename) (newline)
             ;; (display "dst-dir-path=") (write dst-dir-path) (newline)
             ;; (display "dst-dirname=") (write dst-dirname) (newline)

             (snow-create-directory-recursive dst-dirname)

             (cond ((or (snow-file-exists? dst-filename)
                        (snow-file-symbolic-link? dst-filename))
                    (snow-delete-file dst-filename)))

               (snow-create-symbolic-link
                (cond ((snow-filename-relative? src-filename)
                       ;; we are making a link in a subdirectory,
                       ;; so prepend the required number of ../
                       (let* ((link-parts (snow-split-filename dst-filename))
                              (depth (length link-parts))
                              (dots (make-list (- depth 1) "..")))
                         (apply snow-make-filename
                                (reverse (cons src-filename dots)))))
                      (else src-filename))
                dst-filename)))
           manifest)))


      (define (install-from-directory repo package url)
        (let* ((url-path (uri->string url))
               (repo-path (uri->string (snow2-repository-url repo)))
               (package-file (snow-filename-strip-directory url-path))
               (package-name (snow-filename-strip-extension package-file))
               ;; (package-local-directory
               ;;  (snow-make-filename repo-path package-name))
               )
          (cond ((and use-symlinks
                      ;; (snow-file-directory? package-local-directory)
                      #t)
                 (install-symlinks repo package
                                   ;; package-local-directory
                                   ))
                (else
                 (let ((local-package-filename
                        (snow-make-filename repo-path package-file)))
                   (display "extracting ")
                   (display package-file)
                   (display " from ")
                   (display repo-path)
                   (newline)
                   (install-from-tgz repo local-package-filename))))))

      (let* ((pkgs (find-packages-with-libraries repositories library-names))
             (libraries (snow2-packages-libraries pkgs))
             (packages (gather-depends repositories libraries)))
        (for-each
         (lambda (package)
           (let* ((package-repo (snow2-package-repository package))
                  (url (snow2-package-url package))
                  (success
                   (cond
                    ((snow2-repository-local package-repo)
                     (install-from-directory package-repo package url))
                    (else
                     (install-from-http package-repo package url)))))
             (cond
              ((not success)
               (display "Failed to install " (current-error-port))
               (display (snow2-package-name package)
                        (current-error-port))
               (display ", " (current-error-port))
               (display (uri->string (snow2-package-url package))
                        (current-error-port))
               (newline (current-error-port))))))
         packages)))


    (define (uninstall repositories library-names)
      #f)


    (define (list-depends repositories library-names)
      ;; print out what library-name depends on
      (let* ((pkgs (find-packages-with-libraries repositories library-names))
             (libraries (snow2-packages-libraries pkgs))
             (packages (gather-depends repositories libraries)))
        (for-each
         (lambda (package)
           (for-each
            (lambda (library)
              (display (snow2-library-name library))
              (newline))
            (snow2-package-libraries package)))
         packages)))


    (define (filter-libraries libs search-term)
      (let loop ((libs libs)
                 (results '()))
        (cond ((null? libs) (reverse results))
              (else
               (let* ((lib (car libs))
                      (name-as-string
                       (write-to-string (snow2-library-name lib))))
                 (loop (cdr libs)
                       (if (string-contains-ci name-as-string search-term)
                           (cons lib results)
                           results)))))))


    (define (search-for-libraries repositories search-terms)
      (for-each
       (lambda (result)
         (display (snow2-library-name result))
         (newline))
       (let loop ((search-terms search-terms)
                  (libs (all-libraries repositories)))
         (if (null? search-terms) libs
             (loop (cdr search-terms)
                   (filter-libraries libs (car search-terms)))))))


    (define (all-libraries repositories)
      ;; make a list of all libraries in all repositories
      (let repo-loop ((repositories repositories)
                      (results '()))
        (cond ((null? repositories) results)
              (else
               (let pkg-loop ((packages (snow2-repository-packages
                                         (car repositories)))
                              (results results))
                 (cond ((null? packages)
                        (repo-loop (cdr repositories)
                                   results))
                       (else
                        (pkg-loop
                         (cdr packages)
                         (append results
                                 (snow2-package-libraries
                                  (car packages)))))))))))



    (define (client repository-urls operation library-names
                    use-symlinks verbose)
      (let ((repositories (get-repositories-and-siblings '() repository-urls)))

        (cond (verbose
               (display "repositories:\n" (current-error-port))
               (for-each
                (lambda (repository)
                  (display "  " (current-error-port))
                  (display (snow2-repository-url repository)
                           (current-error-port))
                  (newline (current-error-port)))
                repositories)))

        (cond ((equal? operation "install")
               (install repositories library-names use-symlinks verbose))
              ((equal? operation "uninstall")
               (uninstall repositories library-names))
              ((equal? operation "list-depends")
               (list-depends repositories library-names))
              (else
               (error "unknown snow2 client operation" operation)))))


    (define options
      (list
       (option '(#\r "repo") #t #f
               (lambda (option name arg operation repos
                               use-symlinks libs verbose)
                 (values operation
                         (reverse (cons (uri-reference arg) (reverse repos)))
                         use-symlinks libs verbose)))

       (option '(#\s "symlink") #f #f
               (lambda (option name arg operation repos
                               use-symlinks libs verbose)
                 (values operation repos #t libs verbose)))

       (option '(#\v "verbose") #f #f
               (lambda (option name arg operation repos
                               use-symlinks libs verbose)
                 (values operation repos use-symlinks libs #t)))

       (option '(#\h "help") #f #f
               (lambda (option name arg operation repos
                               use-symlinks libs verbose)
                 (usage "")))))


    (define (usage msg)
      (let ((pargs (command-line)))
        (display msg (current-error-port))
        (display (car pargs) (current-error-port))
        (display " " (current-error-port))
        (display "[arguments] <operation> '(library name)' ...\n"
                 (current-error-port))
        (display "  <operation> can be \"install\" or " (current-error-port))
        (display "\"uninstall\" or \"list-depends\" or \"search\"\n"
                 (current-error-port))
        (display "  -r --repo <url>      " (current-error-port))
        (display "Prepend to list of snow2 repositories.\n"
                 (current-error-port))
        (display "  -s --symlink         " (current-error-port))
        (display "Make symlinks to a repo's source files.\n")
        (display "  -v --verbose         " (current-error-port))
        (display "Print more.\n" (current-error-port))
        (display "  -h --help            " (current-error-port))
        (display "Print usage message.\n" (current-error-port))
        (display "\nExample: snow2 install '(snow srfi-13-strings)'\n")
        (exit 1)))


    (define (read-library-name library-name-argument)
      (snow-with-exception-catcher
       (lambda (exn)
         (usage
          (string-append
           "\nincorrectly formatted library-name argument: \""
           library-name-argument
           "\"\n\n")))
       (lambda ()
         (read-from-string library-name-argument))))


    (define (main-program)
      (let-values
          (((operation repository-urls use-symlinks args verbose)
            (args-fold
             (cdr (command-line))
             options
             ;; unrecognized
             (lambda (option name arg . seeds)
               ;; (error "Unrecognized option:" name)
               (usage (string-append "Unrecognized option:"
                                     (if (string? name) name (string name))
                                     "\n\n")))
             ;; operand (arguments that don't start with a hyphen)
             (lambda (operand operation repos use-symlinks libs verbose)
               (if operation
                   (values operation repos use-symlinks
                           (cons operand libs) verbose)
                   (values operand repos use-symlinks libs verbose)))
             #f ;; initial value of operation
             '() ;; initial value of repos
             #f ;; initial value of use-symlinks
             '() ;; initial value of libs
             #f ;; initial value of verbose
             )))
        (let ((repository-urls
               (if (null? repository-urls)
                   (list
                    (uri-reference
                     "http://snow2.s3-website-us-east-1.amazonaws.com/"))
                   repository-urls)))
          (cond ((not operation) (usage ""))
                ;; search operation
                ((member operation '("search"))
                 (let ((repositories (get-repositories-and-siblings
                                      '() repository-urls)))
                   (search-for-libraries repositories args)))
                ;; tar up a package
                ((member operation '("package"))
                 (let ((repositories (get-repositories-and-siblings
                                      '() repository-urls)))
                   (make-package-archives repositories args)))
                ;; other operations
                ((not (member operation '("link-install"
                                          "install"
                                          "uninstall"
                                          "list-depends"
                                          )))
                 (usage (string-append "Unknown operation: "
                                       operation "\n\n")))
                (else
                 (let ((library-names (map read-library-name args)))
                   (cond (verbose
                          (display "libraries to install:\n"
                                   (current-error-port))
                          (write library-names)
                          (newline)))
                   (client repository-urls operation
                           library-names use-symlinks verbose))
                 )))))))

;; "http://snow2.s3-website-us-east-1.amazonaws.com/"
;; "http://snow-repository.s3-website-us-east-1.amazonaws.com/"
