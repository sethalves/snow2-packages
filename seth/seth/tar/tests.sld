(define-library (seth tar tests)
  (export run-tests)
  (import (scheme base)
          (seth tar))
  (begin
    (define (run-tests)
      (extract "test-output.tar")
      #t)))
