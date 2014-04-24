(define-library (seth snow2 manage)
  (export make-package-archives
          ;;upload
          )

  (import (scheme base)
          (scheme read)
          (scheme write)
          (scheme file)
          (scheme process-context))
  (cond-expand
   (chibi (import (only (srfi 1) filter make-list any fold last)))
   (else (import (srfi 1))))
  (import (snow tar)
          (seth uri)
          (seth snow2 types)
          (seth snow2 utils))

  (begin

    (define (make-package-archive local-repository package)
      ;; (display "repo: ")
      ;; (write (snow2-repository-url local-repository))
      ;; (newline)
      ;; (display "package: ")
      ;; (write package-file)
      ;; (newline)

      (let* ((libraries (snow2-package-libraries package))
             (manifest (fold append '() (map get-library-manifest libraries)))
             (tar-recs (fold append '() (map tar-read-file manifest)))
             (url (snow2-package-url package))
             (local-package-filename (last (uri-path url)))
             )
        (display "manifest=")
        (write manifest)
        (newline)
        (display "output-file=")
        (write local-package-filename)
        (newline)

        (tar-pack-file tar-recs local-package-filename)
      ))

    (define (make-package-archives repositories package-files)
      (let ((repositories (filter snow2-repository-local repositories)))
        (cond ((null? repositories)
               (display "no local repositories given.\n" (current-error-port))
               (exit 1))
              ((> (length repositories) 1)
               (display "multiple local repositories given.\n"
                        (current-error-port))
               (exit 1))
              (else
               (map
                (lambda (package-file)
                  (let* ((package-port (open-input-file package-file))
                         (package-sexp (read package-port))
                         (package (package-from-sexp package-sexp)))
                    (make-package-archive (car repositories) package)))
                package-files)))))


;    (define (upload repo-directory package-file)
;      #f)

    ))
