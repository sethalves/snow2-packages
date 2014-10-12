(define-library (seth gensym tests)
  (export run-tests)
  (import (scheme base)
          (scheme write)
          (seth gensym))
  (begin
    (define (run-tests)

      (display (gensym "ok")) (newline)
      (display (gensym "ok")) (newline)
      (display (gensym "ok")) (newline)

      #t)))
