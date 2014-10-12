(define-library (seth cout tests)
  (export run-tests)
  (import (scheme base)
          (seth cout))
  (begin
    (define (run-tests)
      (let ((s (open-output-string)))
        (cout "abc " #t " " 555 " " 'okay "\n" s)
        (equal? (get-output-string s) "abc #t 555 okay\n")))))
