(define-library (snow tar tests)
  (export run-tests)
  (import (scheme base)
          (snow tar))
  (begin
    (define (run-tests)
      #t)))
