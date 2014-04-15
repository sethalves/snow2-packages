(define-library (seth aws s3)
  (export
   list-buckets
   list-bucket
   get-object
   )
  (import (scheme base)
          (scheme write)
          (snow srfi-13-strings)
          (seth uri)
          (seth aws common)
          )
  (begin

    (define s3-authority "s3.amazonaws.com")


    (define (make-s3-uri bucket key)
      (let ((path (if key (string-tokenize key char-set:uri-unreserved) '())))
        (make-uri
         'scheme 'http
         'host (if bucket (string-append bucket "." s3-authority) s3-authority)
         'port 80
         'path (cons '/ path))))


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
       '((x . "http://s3.amazonaws.com/doc/2006-03-01/")) ;; ns
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
       '((x . "http://s3.amazonaws.com/doc/2006-03-01/")) ;; ns
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
       '((x . "http://s3.amazonaws.com/doc/2006-03-01/")) ;; ns
       #t ;; no-xml
       #f ;; no-auth
       "application/x-www-form-urlencoded" ;; content-type
       0 ;; content-length
       #f ;; acl
       ))

    ))
