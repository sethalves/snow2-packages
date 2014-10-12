(define-library (seth string-read-write tests)
  (export run-tests)
  (import (scheme base)
          (scheme write)
          (seth string-read-write))
  (begin
    (define (run-tests)
      (and

       (equal? (write-to-string '(1 2 3)) "(1 2 3)")

       (equal? (read-from-string "(1 2 3)") '(1 2 3))

       (equal?
        (with-output-to-string
          (lambda ()
            (display "ok")))
        "ok")

       ))))
