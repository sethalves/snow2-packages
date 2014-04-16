(define-library (seth aws s3)
  (export
   list-buckets
   list-bucket
   get-object
   )
  (import (scheme base)
          (scheme write)
          (seth uri)
          (seth aws common)
          )
  (begin

    ;; http://docs.aws.amazon.com/AmazonS3/latest/API/APIRest.html

    (define s3-authority "s3.amazonaws.com")
    (define s3-namespace "http://s3.amazonaws.com/doc/2006-03-01/")


    (define (make-s3-uri bucket key)
      (make-uri
       'scheme 'http
       'host (if bucket (string-append bucket "." s3-authority) s3-authority)
       'port 80
       'path (make-path key)))


    (define (make-s3-resource bucket path)
      (string-append "/"
                     (if bucket (string-append bucket "/") "")
                     (if path path "")))


    (define (list-buckets credentials)

      (perform-aws-request
       credentials ;; credentials
       (make-s3-uri #f #f)
       (make-s3-resource #f #f)
       '(x:ListAllMyBucketsResult x:Buckets x:Bucket x:Name *text*) ;; sxpath
       "" ;; body
       "GET" ;; verb
       `((x . ,s3-namespace)) ;; ns
       #f ;; no-xml
       #f ;; no-auth
       "application/x-www-form-urlencoded" ;; content-type
       0 ;; content-length
       #f ;; acl
       ))


    (define (list-bucket credentials bucket)
      (perform-aws-request
       credentials
       (make-s3-uri bucket #f)
       (make-s3-resource bucket #f)
       '(x:ListBucketResult x:Contents x:Key *text*) ;; sxpath
       "" ;; body
       "GET" ;; verb
       `((x . ,s3-namespace)) ;; ns
       #f ;; no-xml
       #f ;; no-auth
       "application/x-www-form-urlencoded" ;; content-type
       0 ;; content-length
       #f ;; acl
       ))


    (define (get-object credentials bucket key)
      (perform-aws-request
       credentials
       (make-s3-uri bucket key)
       (make-s3-resource bucket key)
       '(x:ListBucketResult x:Contents x:Key *text*) ;; sxpath
       "" ;; body
       "GET" ;; verb
       `((x . ,s3-namespace)) ;; ns
       #t ;; no-xml
       #f ;; no-auth
       "application/x-www-form-urlencoded" ;; content-type
       0 ;; content-length
       #f ;; acl
       ))

    ))
