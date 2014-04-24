(define (main-program)

  (define os-is-unix? #t) ;; assume this is Unix

  (define (write-lines lst port)
    (for-each (lambda (x)
                (display x port)
                (newline port))
              lst)
    (snow-force-output port))

  (define (read-one-line port)
    (let loop ((lst '()))
      (let ((c (read-char port)))
        (cond ((or (eof-object? c) (char=? c #\newline))
               (list->string (reverse lst)))
              ((char<? c #\space)
               (loop lst))
              (else
               (loop (cons c lst)))))))

  (define (read-lines port)
    (let loop ((lst '()))
      (let ((x (read-one-line port)))
        (if (string=? x "")
            (reverse lst)
            (loop (cons x lst))))))



;; (for-each
;;  (lambda (n-v)
;;    (write n-v)
;;    (newline))
;;  (get-environment-variables))
;; (newline)
;; (newline)


  (define test-subdir
    (let* ((env (get-environment-variables))
           (pwd (cdr (assoc "PWD" env))))
      (snow-make-filename pwd "test-subdir")))


  (snow-with-exception-catcher
   (lambda (exn)
     (cond ((snow-condition? exn)
            (write (snow-error-condition-msg exn))
            (newline)
            (write (snow-error-condition-args exn))
            (newline))
           (else
            (display exn)))
     #f)



   (lambda ()

     (snow-assert
      (equal? (snow-subprocess-run '("/bin/ls") test-subdir) "a\nb\n"))

     (snow-assert
      (equal? '("1" "2" "3" "4" "5" "6" "7" "8" "9")
              (let* ((p (snow-open-shell-command-process
                         "sort")) ;; "sort" exists on Unix and Windows
                     (in (shell-command-process-input-port p))
                     (out (shell-command-process-output-port p)))
                (write-lines '("3" "8" "1" "2" "7" "9" "5" "4" "6") out)
                (close-output-port out)
                (let ((result (read-lines in)))
                  (close-input-port in)
                  (snow-subprocess-wait p)
                  result))))

     (if os-is-unix?
         (begin

           (snow-assert
            (equal? '("3" "12")
                    (let* ((p (snow-open-shell-command-process "bc" "-q"))
                           (in (shell-command-process-input-port p))
                           (out (shell-command-process-output-port p)))
                      (write-lines '("1+2") out)
                      (let ((line1 (read-one-line in)))
                        (write-lines '("3*4") out)
                        (let ((line2 (read-one-line in)))
                          (close-output-port out)
                          (close-input-port in)
                          (list line1 line2))))))

           (snow-assert (let* ((p (snow-open-shell-command-process "cat"))
                               (in (shell-command-process-input-port p))
                               (out (shell-command-process-output-port p))
                               (low-c 0)
                               (high-c 256)
                               )
                          (let loop ((i low-c))
                            (if (< i high-c)
                                (begin
                                  (write-char (integer->char i) out)
                                  (loop (+ i 1)))))
                          (snow-force-output out)
                          (let loop ((i low-c))
                            (if (< i high-c)
                                (let ((c (read-char in)))
                                  (if (not (= i (char->integer c)))
                                      #f
                                      (loop (+ i 1))))
                                #t))))






           ))

     #t)))
