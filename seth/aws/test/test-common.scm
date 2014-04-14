(define (main-program)

  (let ((credentials (read-credentials "credentials")))
    (write (list-buckets credentials))
    (newline))

  #t)
