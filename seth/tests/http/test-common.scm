
(define start-time 0)


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
  ;;    (let ((body (read-string 300
  ;;                             ;; body-port
  ;;                             (binary-port->textual-port body-port)
  ;;                             )))
  ;;      (let loop ((i 0))
  ;;        (cond ((< i 256)
  ;;               (write (string-ref body i))
  ;;               (display " ")
  ;;               (loop (+ i 1)))))
  ;;      (newline)
  ;;      (display (string-length body))

  ;;      )))



  (let ((result0 #f)
        (result1 #f)
        (result2 #f)
        (result3 #f)
        (result4 #f)
        (result5 #f)
        )

    (set! start-time (current-second))

    (call-with-request-body
     "http://headache.hungry.com/~seth/ok"
     (lambda (body-port)
       (let ((body (utf8->string (read-all-u8 body-port))))
         (cond ((equal? body "this is a test file\n")
                (set! result0 (- (current-second) start-time)))))))

    ;; (display "done 0 ") (write (- (current-second) start-time)) (newline);; XXX

    (cond ((file-exists? "test-download")
           (delete-file "test-download")))

    (set! start-time (current-second))

    (let ((outp
           ;; (cond-expand
           ;;  (sagittarius
           ;;   (open-binary-output-file "test-download"
           ;;                            :transcoder #f
           ;;                            ))
           ;;  (else
           ;;   (open-output-file "test-download")))
           (open-binary-output-file "test-download")
           ))
      (download-file "http://headache.hungry.com/~seth/ok" outp)

      (let* ((inp (open-binary-input-file "test-download"))
             (test-data (utf8->string (read-all-u8 inp))))
        (cond ((equal? test-data "this is a test file\n")
               (set! result1 (- (current-second) start-time)))))

      ;; (delete-file "test-download")
      )

    ;; (display "done 1 ") (write (- (current-second) start-time)) (newline);; XXX

    (set! start-time (current-second))

    (let ((index-scm (call-with-request-body
                      "http://snow2.s3-website-us-east-1.amazonaws.com/"
                      ;; read
                      (lambda (p)
                        (read (binary-port->textual-port p))))))
      (cond ((and (list? index-scm)
                  (eq? (car index-scm) 'repository))
             (set! result2 (- (current-second) start-time)))
            (else
             (write index-scm)
             (newline))
            ))

    ;; (display "done 2 ") (write (- (current-second) start-time)) (newline);; XXX

    (set! start-time (current-second))

    (http 'GET "http://headache.hungry.com/~seth/ok" #f
          (lambda (status-code headers response-body-port)
            (let* ((content-length (http-header-as-integer
                                    headers 'content-length 0))
                   (body8 (read-bytevector content-length response-body-port))
                   (body (utf8->string body8)))
              (cond ((equal? body "this is a test file\n")
                     (set! result3 (- (current-second) start-time)))))))

    ;; (display "done 3 ") (write (- (current-second) start-time)) (newline);; XXX

    (set! start-time (current-second))

    (let ((url "http://tester.hungry.com/chunked-response-body/"))
      (let-values (((status headers body) (http 'GET url #f #f)))
        ;; (write (string-length body))
        ;; (newline)
        (let ((body (utf8->string body)))
          (set! result4
                (and
                 (= (string-length body) 966)
                 (equal? (substring body 0 20)
                         "\n`Twas brillig, and ")
                 (- (current-second) start-time))))
        ))

    ;; (display "done 4 ") (write (- (current-second) start-time)) (newline);; XXX

    (cond ((file-exists? "test-download")
           (delete-file "test-download")))

    (set! start-time (current-second))

    (let ((outp
           (cond-expand
            (sagittarius
             (open-output-file "test-download" :transcoder #f))
            (else
             (open-output-file "test-download")))))
      (download-file "http://headache.hungry.com/~seth/8bits" outp)

      (let* ((inp (open-binary-input-file "test-download"))
             (test-data (read-all-u8 inp)))
        (cond ((= (bytevector-length test-data) 256)
               (let loop ((i 0))
                 (cond ((= i 256)
                        (set! result5 (- (current-second) start-time)))
                       ((not (= i (bytevector-u8-ref test-data i)))
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

    ;; (display "done 5 ") (write (- (current-second) start-time)) (newline);; XXX

    (write (list result0 result1 result2 result3 result4 result5))
    (newline)

    (and result0 result1 result2 result3 result4 result5 #t)))
