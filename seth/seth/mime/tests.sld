(define-library (seth mime tests)
  (export run-tests)
  (import (scheme base)
          (scheme write)
          (seth mime))
  (begin


    (define (test-0)
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


    (define (test-1)
      (and
       (equal? (assq-set '((a . "ok") (b . "fuh") (c . 5)) 'd "blee")
               '((a . "ok") (b . "fuh") (c . 5) (d . "blee")))
       (equal? (assq-set '((a . "ok") (b . "fuh") (c . 5)) 'c "blee")
               '((a . "ok") (b . "fuh") (c . "blee")))
       (equal? (assq-set '() 'c "blee")
               '((c . "blee")))
       (equal? (assq-set '((a . "ok") (b . "fuh") (c . 5)) 'a "blee")
               '((a . "blee") (b . "fuh") (c . 5)))

       ))


    (define (run-tests)
      (and (test-0)
           (test-1)))))
