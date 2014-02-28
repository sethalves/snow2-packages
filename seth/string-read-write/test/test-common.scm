

(define (main-program)
  (and
   (equal? (write-to-string '(1 2 3)) "(1 2 3)")
   (equal? (read-from-string "(1 2 3)") '(1 2 3)))
  )
