(define-library (seth temporary-file tests)
  (export run-tests)
  (import (scheme base)
          (scheme write)
          (seth temporary-file))
  (begin
    (define (run-tests)

      (let-values (((output-port tmp-file-name)
                    (temporary-file)))
        (temporary-file)
        (display "port=")
        (display output-port)
        (newline)
        (display "tmp-file-name=")
        (display tmp-file-name)
        (newline))

      #t)))
