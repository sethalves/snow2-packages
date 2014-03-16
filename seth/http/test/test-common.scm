(define (main-program)


  ;; (call-with-request-body
  ;;  "http://headache.hungry.com:1777/cgi-bin/oversend"
  ;;  (lambda (body-port)
  ;;    (let ((body (read-all-chars body-port)))
  ;;      (display "'")
  ;;      (display body)
  ;;      (display "'")
  ;;      (newline)
  ;;      )))


  ;; (call-with-request-body
  ;;  "http://headache.hungry.com:1777/cgi-bin/chunked"
  ;;  (lambda (body-port)
  ;;    (let ((body (read-all-chars body-port)))
  ;;      (display "'")
  ;;      (display body)
  ;;      (display "'")
  ;;      (newline)
  ;;      )))


  ;; (call-with-request-body
  ;;  "http://headache.hungry.com:1777/cgi-bin/binary"
  ;;  (lambda (body-port)
  ;;    (let ((body (read-all-latin-1-chars body-port)))
  ;;      (let loop ((i 0))
  ;;        (cond ((< i 256)
  ;;               (write (string-ref body i))
  ;;               (display " ")
  ;;               (loop (+ i 1))))))))



  (let ((result0 #f)
        (result1 #f)
        (result2 #f)
        (result3 #f)
        (result4 #f)
        (result5 #f)
        )

    (call-with-request-body
     "http://headache.hungry.com/~seth/ok"
     (lambda (body-port)
       (let ((body (read-all-latin-1-chars body-port)))
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
             (test-data (read-all-latin-1-chars inp)))
        (cond ((equal? test-data "this is a test file\n")
               (set! result1 #t))))

      ;; (delete-file "test-download")
      )

    (let ((index-scm (call-with-request-body
                      "http://snow2.s3-website-us-east-1.amazonaws.com/"
                      ;; read
                      (lambda (p)
                        (read (binary-port->latin-1-textual-port p))))))
      (cond ((and (list? index-scm)
                  (eq? (car index-scm) 'repository))
             (set! result2 #t))
            (else
             (write index-scm)
             (newline))
            ))


    (http 'GET "http://headache.hungry.com/~seth/ok" #f
          (lambda (status-code headers response-body-port)

            ;; (display "(binary-port? response-body-port) --> ")
            ;; (write (binary-port? response-body-port))
            ;; (newline)

            (let* ((content-length (http-header-as-integer
                                    headers 'content-length 0))
                   (body (read-latin-1-string
                          content-length response-body-port)))
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

    (cond ((file-exists? "test-download")
           (delete-file "test-download")))

    (let ((outp
           (cond-expand
            (sagittarius
             (open-output-file "test-download" :transcoder #f))
            (else
             (open-output-file "test-download")))))
      (download-file "http://headache.hungry.com/~seth/8bits" outp)

      (let* ((inp (open-binary-input-file "test-download"))
             (test-data (read-all-latin-1-chars inp)))
        (cond ((= (string-length test-data) 256)
               (let loop ((i 0))
                 (cond ((= i 256) (set! result5 #t))
                       ((not (= i (char->integer (string-ref test-data i))))
                        (display "8-bit mismatch at ")
                        (write i)
                        (newline))
                       (else
                        (loop (+ i 1))))))
              (else
               (display "8bit data length=")
               (write (string-length test-data))
               (newline)))
        )

      ;; (delete-file "test-download")
      )

    (write (list result0 result1 result2 result3 result4 result5))
    (newline)

    (and result0 result1 result2 result3 result4 result5)))
