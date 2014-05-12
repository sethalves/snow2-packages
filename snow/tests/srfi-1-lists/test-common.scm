
(define (main-program)
  (and

   (equal? (list 3 2 1) (fold cons '() (list 1 2 3)))

   #t

   ))
