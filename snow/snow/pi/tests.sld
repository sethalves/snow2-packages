
(define-library (snow pi tests)
  (export run-tests)
  (import (scheme base)
          (snow pi))

  (begin
    (define (run-tests)
      (equal? "31415926510" (pi-digits 10)))
    ))
