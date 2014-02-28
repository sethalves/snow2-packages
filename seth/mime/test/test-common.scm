(define (main-program)

  (let ((in (open-input-string
             (string-append
              "Date: Sun, 23 Feb 2014 17:27:20 GMT\r\n"
              "Server: Apache/2.2.14 (Ubuntu)\r\n"
              "Vary: Accept-Encoding\r\n"
              "Content-Length: 296\r\n"
              "Content-Type: text/html; charset=iso-8859-1\r\n"
              ))))
    (display
     (mime-headers->list in)
     )
    (close-input-port in)
    (newline)

    #t))
