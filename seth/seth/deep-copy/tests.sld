(define-library (seth deep-copy tests)
  (export run-tests)
  (import (scheme base)
          (seth deep-copy))
  (begin
    (define (run-tests)
      (let* ((a `(1 2 (3 4) ,(vector #\a 10) #t #f "ok ok ok" ,(cons 6 7) '()))
             (b (deep-copy a)))
        (and (equal? a b)
             (not (eq? a b)))))))
