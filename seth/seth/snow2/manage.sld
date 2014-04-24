(define-library (seth snow2-utils)
  (export package
          upload)

  (import (scheme base)
          (scheme read)
          (scheme write)
          (scheme file)
          (scheme process-context))
  (cond-expand
   (chibi (import (only (srfi 1) filter make-list any fold)))
   (else (import (srfi 1))))


  (begin

    (define (package repo-directory package-file)
      #f)

    (define (upload repo-directory package-file)
      #f)

    ))
