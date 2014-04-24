


(define (main-program)
  (random-source-randomize! default-random-source)
  (display (uuid:random))
  (newline)
  #t)
