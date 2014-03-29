
(define (main-program)
  (let ((tests
         (list
          (list "" (hex-string->bytes "d41d8cd98f00b204e9800998ecf8427e"))
          (list "a" (hex-string->bytes "0cc175b9c0f1b6a831c399e269772661"))
          (list "abc" (hex-string->bytes "900150983cd24fb0d6963f7d28e17f72"))
          (list "message digest"
                (hex-string->bytes "f96b697d7cb7938d525a2f31aaf161d0"))
          (list "abcdefghijklmnopqrstuvwxyz"
                (hex-string->bytes "c3fcd3d76192e4007dfb496cca67e13b"))
          (list (string-append "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklm"
                               "nopqrstuvwxyz0123456789")
                (hex-string->bytes "d174ab98d277d9f5a5611c2c9f419d9f"))
          (list (string-append "1234567890123456789012345678901234567890"
                               "1234567890123456789012345678901234567890")
                (hex-string->bytes "57edf4a22be3c955ac49da2e2107b67a"))
          )))

    (let loop ((tests tests))
      (if (null? tests) #t
          (let ((test (car tests)))
            (if (equal? (md5 (string->utf8 (car test)))
                        (cadr test))
                (loop (cdr tests))
                #f))))))