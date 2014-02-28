(define (main-program)
  (let ((result0 #f)
        (result1 #f))

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

    (and result0 result1)))
