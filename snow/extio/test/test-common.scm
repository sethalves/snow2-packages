(define (main-program)
  (snow-force-output)
  (snow-force-output (current-output-port))
  (snow-pretty-print '(1 2 3))
  (snow-pretty-print '(1 2 3) (current-output-port))
  #t)