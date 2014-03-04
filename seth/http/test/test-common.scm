(define (main-program)
  (let ((result0 #f)
        (result1 #f)
        (result2 #f)
        (result3 #f)
        (result4 #f)
        )

    (call-with-request-body
     "http://headache.hungry.com/~seth/ok"
     (lambda (body-port)
       (let ((body (read-all-chars body-port)))
         ;; (display "'")
         ;; (display body)
         ;; (display "'")
         ;; (newline)
         (cond ((equal? body "this is a test file\n")
                (set! result0 #t))))))

    (cond ((file-exists? "test-download")
           (delete-file "test-download")))

    (let ((outp
           (cond-expand
            (sagittarius
             (open-output-file "test-download" :transcoder #f))
            (else
             (open-output-file "test-download")))))
      (download-file "http://headache.hungry.com/~seth/ok" outp)

      (let* ((inp (open-input-file "test-download"))
             (test-data (read-all-chars inp)))
        (cond ((equal? test-data "this is a test file\n")
               (set! result1 #t))))

      ;; (delete-file "test-download")
      )


    (let ((index-scm (call-with-request-body
                      "http://snow2.s3-website-us-east-1.amazonaws.com/"
                      read)))
      (cond ((and (list? index-scm)
                  (eq? (car index-scm) 'repository))
             (set! result2 #t))
            (else
             (write index-scm)
             (newline))
            ))


    (http 'GET "http://headache.hungry.com/~seth/ok" #f
          (lambda (status-code headers response-body-port)
            (let* ((content-length (http-header-as-integer
                                    headers 'content-length 0))
                   (body (read-string content-length response-body-port)))
              ;; (display "headers=")
              ;; (write headers)
              ;; (newline)
              ;; (display "content-length=")
              ;; (write content-length)
              ;; (newline)
              ;; (display "body=")
              ;; (write body)
              ;; (newline)
              (cond ((equal? body "this is a test file\n")
                     (set! result3 #t))))))

    (let ((url "http://tester.hungry.com/chunked-response-body/"))
      (let-values (((status headers body) (http 'GET url #f #f)))
        ;; (write (string-length body))
        ;; (newline)
        (set! result4
              (and
               (= (string-length body) 966)
               (equal? (substring body 0 20)
                       "\n`Twas brillig, and ")))
        ))

    ;; (write (list result0 result1 result2 result3 result4))
    ;; (newline)

    (and result0 result1 result2 result3 result4)))
