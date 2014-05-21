(define (main-program)
  (snow-assert #t)

  (guard
   (exn (#t #t))
   (snow-assert (= 1 3)))

  #t)
