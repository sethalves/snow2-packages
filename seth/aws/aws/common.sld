(define-library (seth aws common)
  (export read-credentials
          make-credentials
          credentials?
          credentials-access-key-id
          credentials-secret-access-key
          perform-aws-request
          )

  (import (scheme base)
          (scheme char)
          (scheme write)
          (scheme file)
          (srfi 1)
          (snow bytevector)
          (snow srfi-95-sort)
          (snow srfi-29-format)
          (snow srfi-19-time)
          (snow extio)
          (seth xml ssax)
          (seth xml sxpath)
          (seth http)
          (seth hmac)
          (seth port-extras)
          (seth uri)
          (prefix (seth base64) base64-)
          )

  (begin

    (log-http-to-stderr #t)

    (define-record-type <credentials>
      (make-credentials access-key-id secret-access-key)
      credentials?
      (access-key-id credentials-access-key-id)
      (secret-access-key credentials-secret-access-key))

    (define (read-credentials filename)
      ;; XXX make a better parser
      (let* ((creds-hndl (open-input-file filename))
             (creds-line0 (read-line creds-hndl))
             (creds-line1 (read-line creds-hndl)))
        (close-input-port creds-hndl)
        (make-credentials
         (substring creds-line0 15 (string-length creds-line0))
         (substring creds-line1 13 (string-length creds-line1)))))



    (define (sig-date date) (date->string date "~a, ~d ~b ~Y ~T GMT"))


    ;; http://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html

    ;; GET /photos/puppy.jpg HTTP/1.1
    ;; Host: johnsmith.s3.amazonaws.com
    ;; Date: Mon, 26 Mar 2007 19:37:58 +0000
    ;; Authorization: AWS AKIAIOSFODNN7EXAMPLE:frJIUN8DYpKDtOLCwo//yllqDzg=


    (define (make-aws-authorization credentials
                                    verb
                                    resource
                                    date
                                    amz-headers
                                    content-md5
                                    content-type)
      (let* ((can-amz-headers
              (sort (map (lambda (header)
                           `(,(string-downcase (car header)) . ,(cdr header)))
                         amz-headers)
                    (lambda (v1 v2)
                      (string<? (car v1) (car v2)))))
             (can-string
              (string-append
               (string-upcase verb) "\n"
               (if content-md5 content-md5 "") "\n"
               (if content-type content-type "") "\n"
               (if date date "") "\n"
               (fold (lambda (e o)
                       (string-append o (format "~a:~a~%" (car e) (cdr e))))
                     ""
                     can-amz-headers)
               resource)))

        (latin-1->string
         (base64-encode
          (hmac-sha1 (credentials-secret-access-key credentials)
                     can-string)))))


    (define (perform-aws-request credentials
                                 uri
                                 resource
                                 sx-path
                                 body
                                 verb
                                 ns
                                 no-xml
                                 no-auth
                                 content-type
                                 content-length
                                 acl)

      (define (aws-auth-header now)
        (let ((value (string-append
                      "AWS " (credentials-access-key-id credentials) ":"
                      (make-aws-authorization
                       credentials
                       verb ;; verb

                       ;; resource
;                       (string-append "/"
;                                      (if bucket (string-append bucket "/") "")
;                                      (if path path ""))
                       resource

                       (sig-date now) ;; date
                       (if acl (list (cons "X-Amz-Acl" acl)) '()) ;; amz-headers
                       #f ;; content-md5
                       content-type))))
          `(authorization . ,value)))

      (let* ((now (current-date 0))
             (headers `((date . ,(date->string now "~a, ~d ~b ~Y ~T GMT"))
                        ,@(if acl `((x-amz-acl . ,acl)) '())
                        (content-type . ,(string->symbol content-type))
                        (content-length . ,content-length)
                        ))
             )

        (display "verb=") (write verb) (newline)
;        (display "bucket=") (write bucket) (newline)
;        (display "path=") (write path) (newline)
        (display "uri=") (write (uri->string uri)) (newline)
        (display "now=") (write now) (newline)
        (display "headers=") (write headers) (newline)
        (display "body=") (write body) (newline)


        (http verb uri body
              (lambda (status-code headers body-port) ;; reader-thunk
                ;; (newline)
                ;; (display "response status-code=")
                ;; (write status-code)
                ;; (newline)
                ;; (display "response headers=")
                ;; (write headers)
                ;; (newline)
                ;; (display "response body=")
                ;; (write (utf8->string (read-all-u8 body-port)))
                ;; (newline)
                (cond (no-xml (read-all-u8 body-port))
                      (else
                       ((sxpath sx-path)
                        (ssax:xml->sxml
                         (binary-port->latin-1-textual-port body-port)
                         ns)))))
              headers
              (lambda (headers)
                (cond (no-auth headers)
                      (else
                       ;(let ((value (aws-auth-header now)))
                       ;  (cons `(authorization . ,value) headers))
                       (cons (aws-auth-header now) headers)
                       )))
              )))

    ))
