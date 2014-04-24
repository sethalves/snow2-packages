(define (main-program)

  (let-values (((output-port tmp-file-name)
                (temporary-file)))
    (temporary-file)
    (display "port=")
    (display output-port)
    (newline)
    (display "tmp-file-name=")
    (display tmp-file-name)
    (newline))

  #t)
