(define-library (snow input-parse tests)
  (export run-tests)
  (import (scheme base)
          (snow input-parse))
  (begin
    (define (run-tests)

      (let* ((t0 (let ((p (open-input-string "   abc")))
                   (= (find-string-from-port? "abc" p) 6)))
             )

        (and t0)))))
