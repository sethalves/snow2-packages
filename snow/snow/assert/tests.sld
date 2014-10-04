(define-library (snow assert tests)
  (export run-tests)
  (import (scheme base)
          (snow assert))
  (begin
    (define (run-tests)
      (snow-assert #t)

      (guard
       (exn (#t #t))
       (snow-assert (= 1 3))))))

