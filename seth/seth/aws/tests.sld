(define-library (seth aws tests)
  (export run-tests)
  (import (scheme base)
          (scheme write)
          (except (srfi 13)
                  string-copy string-map string-for-each
                  string-fill! string-copy! string->list
                  string-upcase string-downcase)
          (snow bytevector)
          (seth http)
          (seth crypt md5)
          (prefix (seth base64) base64-)
          (seth http)
          (seth crypt md5)
          (seth aws common)
          (seth aws s3)
          (srfi 78))
  (begin

    (define (run-tests~)

      (check-reset!)

      (log-http-to-stderr #f)

      (let (;; (credentials (read-credentials "credentials"))
            (credentials (get-credentials-for-s3-bucket "seth-aws-s3-test")))

        (check (bucket-exists? credentials "snow2") => #t)

        (check (not (bucket-exists? credentials "i-dont-exist")) => #t)

        (check (member "snow2" (list-buckets credentials)) => #t)

        (check (member "aws.tgz" (list-objects credentials "snow2")) => #t)

        (check (let ((data (get-object credentials "snow2" "index.scm")))
                 (cond ((not data) #f)
                       (else
                        (let ((str (utf8->string data)))
                          (string-prefix? "(repository\n" str))))) => #t)

        (check (begin
                 (if (bucket-exists? credentials "seth-aws-s3-test")
                     (delete-bucket! credentials "seth-aws-s3-test"))
                 (create-bucket! credentials "seth-aws-s3-test")
                 (bucket-exists? credentials "seth-aws-s3-test")) => #t)

        (check (begin
                 (put-object! credentials "seth-aws-s3-test" "a-string" "abc")
                 (equal? (get-object credentials "seth-aws-s3-test" "a-string")
                         (string->utf8 "abc"))) => #t)

        (check (equal?
                (get-object-md5 credentials "seth-aws-s3-test" "a-string")
                (md5 "abc")) => #t)

        (check
         (begin
           (delete-object! credentials "seth-aws-s3-test" "a-string")
           (not (get-object credentials "seth-aws-s3-test" "a-string"))) => #t)

        (check-passed? 9)))


    (define (run-tests)
      ;; (guard
      ;;  (exn (#t
      ;;        (display (error-object-message exn))
      ;;        (newline)))
      ;;  (run-tests~))

      (run-tests~)
      )))
