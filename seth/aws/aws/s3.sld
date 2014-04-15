(define-library (seth aws s3)
  (export
   list-buckets
   list-bucket
   )
  (import (scheme base)
          (seth aws common)
          )
  (begin

    (define (list-buckets credentials)

      (perform-aws-request
       credentials ;; credentials
       #f ;; bucket
       "" ;; path
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
       bucket
       "" ;; path
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

    ))
