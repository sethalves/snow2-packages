(define (main-program)

  (let* ((t0 (let ((p (open-input-string "   abc")))
               (= (find-string-from-port? "abc" p) 6)))
         )

    (and t0)))
