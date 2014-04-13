
(define (main-program)

  (let ((tests
         ;; from chicken egg tests
         `(("64608bd9aa157cdfbca795bf9a727fc191a50b66" "hi" "food is good")
           ("511387216297726a7947c6006f5be89711662b1f"
            "hi my name is the big bad wolf" "hi")
           ("73dc948bab4e0c65b1e5d18ae3694a39a4788bee"
            "key" "this is a really long message that is going to being run through this hmac test to make sure that it works correctly.")
           ;; wikipedia
           ("de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9"
            "key" "The quick brown fox jumps over the lazy dog"))))

    (let loop ((tests tests))
      (cond ((null? tests) #t)
            (else
             (let* ((test (car tests))
                    (expected (list-ref test 0))
                    (key (list-ref test 1))
                    (message (list-ref test 2))
                    (calced (bytes->hex-string (hmac-sha1 key message))))
               (if (equal? expected calced)
                   (loop (cdr tests))
                   (begin
                     (display "key: ") (write key) (newline)
                     (display "message: ") (write message) (newline)
                     (display "expected: ") (write expected) (newline)
                     (display "  calced: ") (write calced) (newline)
                     #f))))))))
