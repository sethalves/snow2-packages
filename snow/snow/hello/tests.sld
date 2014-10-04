(define-library (snow hello tests)
  (export run-tests)
  (import (scheme base)
          (snow hello))
  (begin
   (define (run-tests)
     #t)))
