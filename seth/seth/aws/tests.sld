(define-library (seth aws tests)
  (export run-tests)
  (import (scheme base)
          (scheme write)
          (srfi 13)
          (snow bytevector)
          (seth http)
          (seth crypt md5)
          (prefix (seth base64) base64-)
          (seth http)
          (seth crypt md5)
          (seth aws common)
          (seth aws s3))
  (begin

    (define (run-tests~)
      (log-http-to-stderr #f)

      (let ((credentials (read-credentials "credentials")))
        (and

         (bucket-exists? credentials "snow2")

         (not (bucket-exists? credentials "i-dont-exist"))

         (member "snow2" (list-buckets credentials))

         (member "aws.tgz" (list-objects credentials "snow2"))

         (let ((data (get-object credentials "snow2" "index.scm")))
           (cond ((not data) #f)
                 (else
                  (let ((str (utf8->string data)))
                    (string-prefix? "(repository\n" str)))))

         (begin
           (if (bucket-exists? credentials "seth-aws-s3-test")
               (delete-bucket! credentials "seth-aws-s3-test"))
           (create-bucket! credentials "seth-aws-s3-test")
           (bucket-exists? credentials "seth-aws-s3-test"))

         (begin
           (put-object! credentials "seth-aws-s3-test" "a-string" "abc")
           (equal? (get-object credentials "seth-aws-s3-test" "a-string")
                   (string->utf8 "abc")))

         (equal? (get-object-md5 credentials "seth-aws-s3-test" "a-string")
                 (md5 "abc"))

         (begin
           (delete-object! credentials "seth-aws-s3-test" "a-string")
           (not (get-object credentials "seth-aws-s3-test" "a-string")))

         #t)))


    (define (run-tests)
      (guard
       (exn (#t
             (display (error-object-message exn))
             (newline)))
       (run-tests~)))))
