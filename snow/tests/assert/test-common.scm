(define (main-program)
  (snow-assert #t)

  (snow-with-exception-catcher
   (lambda (exn)
     (display "ok\n")
     #t)
   (lambda ()
     (snow-assert (= 1 3))))

  #t)
