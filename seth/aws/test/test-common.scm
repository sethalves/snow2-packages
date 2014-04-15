(define (main-program)

  (let ((credentials (read-credentials "credentials")))
    (write (list-buckets credentials))
    (newline)

    (write (list-bucket credentials "gloebit-deb-repo"))
    (newline)

    )

  #t)
