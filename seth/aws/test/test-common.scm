(define (main-program)

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


     (begin
       (delete-object! credentials "seth-aws-s3-test" "a-string")
       (not (get-object credentials "seth-aws-s3-test" "a-string")))

     #t)))
