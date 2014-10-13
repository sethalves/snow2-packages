;;
;;

(define-library (seth snow2 tests)
  (export run-tests)
  (import (scheme base)
          (seth snow2 client))
  (begin
    (define (run-tests)
      #t)))
