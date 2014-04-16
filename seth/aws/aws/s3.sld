(define-library (seth aws s3)
  (export
   list-buckets
   list-objects

   bucket-exists?
;   create-bucket!
;   delete-bucket!
   get-object
;   put-object!
;   delete-object!

;   put-string!
;   put-sexp!
;   put-file!
;   get-string
;   get-sexp
;   get-file


   )
  (import (scheme base)
          (scheme write)
          (seth uri)
          (only (seth http) response-status-class)
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


    (define (bucket-exists? credentials bucket)
      (let-values
          (((status-code headers data)
            (perform-aws-request
             credentials ;; credentials
             (make-s3-uri bucket #f)
             (make-s3-resource bucket #f)
             '() ;; sxpath
             "" ;; body
             "HEAD" ;; verb
             `((x . ,s3-namespace)) ;; ns
             #t ;; no-xml
             #f ;; no-auth
             "application/x-www-form-urlencoded" ;; content-type
             0 ;; content-length
             #f ;; acl
             )))
        (= (response-status-class status-code) 200)))


    (define (list-buckets credentials)
      (let-values
          (((status-code headers data)
            (perform-aws-request
             credentials ;; credentials
             (make-s3-uri #f #f)
             (make-s3-resource #f #f)
             ;; sxpath
             '(x:ListAllMyBucketsResult x:Buckets x:Bucket x:Name *text*)
             "" ;; body
             "GET" ;; verb
             `((x . ,s3-namespace)) ;; ns
             #f ;; no-xml
             #f ;; no-auth
             "application/x-www-form-urlencoded" ;; content-type
             0 ;; content-length
             #f ;; acl
             )))
        (cond ((= (response-status-class status-code) 200) data)
              (else #f))))


    (define (list-objects credentials bucket)
      (let-values
          (((status-code headers data)
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
             )))
        (cond ((= (response-status-class status-code) 200) data)
              (else #f))))


    (define (get-object credentials bucket key)
      (let-values
          (((status-code headers data)
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
             )))
        (cond ((= (response-status-class status-code) 200) data)
              (else #f))))

    ))
