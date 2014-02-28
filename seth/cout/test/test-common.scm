(define (main-program)
  (let ((s (open-output-string)))
    (cout "abc " #t " " 555 " " 'okay "\n" s)
    (equal? (get-output-string s) "abc #t 555 okay\n")))
