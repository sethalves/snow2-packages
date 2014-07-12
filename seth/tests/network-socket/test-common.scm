
(cond-expand
 (chicken
  ;; XXX
  (define (flush-output-port p)
    #t))
 (else))


(define (u8display str port)
  (write-bytevector (string->utf8 str) port))


(define (test0)
  (let* ((port-no (+ (random-integer 20000) 10000))
         (listen-sock
          (make-network-listener `((host #f) (port ,port-no))))
         (client-sock
          (open-network-client `((host "localhost") (port ,port-no))))
         (server-sock (open-network-server listen-sock)))
    (u8display "ok\n" (socket:outbound-write-port client-sock))
    (flush-output-port (socket:outbound-write-port client-sock))
    (let ((client-sent
           (utf8->string
            (read-bytevector 3 (socket:inbound-read-port server-sock)))))
      (cond ((equal? client-sent "ok\n")
             (u8display "hi\n" (socket:outbound-write-port server-sock))
             (socket:send-eof server-sock)
             (let ((server-sent
                    (utf8->string
                     (read-all-u8 (socket:inbound-read-port client-sock)))))
               (socket:close server-sock)
               (close-network-listener listen-sock)
               (socket:close client-sock)
               (equal? server-sent "hi\n")))
            (else #f)))))


(define (test1)
  (let* ((port-no (+ (random-integer 20000) 10000))
         (server-sock (socket:udp-server (make-network-endpoint #f port-no)))
         (client-sock (socket:make-udp-client
                       (make-network-endpoint #f 0)
                       (make-network-endpoint "localhost" port-no)))
         (client-outbout-port
          (socket:udp-outbound-write-port client-sock)))

    (write "ok\n" client-outbout-port)
    (flush-output-port client-outbout-port)

    (let ((client-sent (read (socket:udp-inbound-read-port server-sock))))
      (socket:udp-close server-sock)
      (socket:udp-close client-sock)
      (equal? client-sent "ok\n"))))


(define (test2)
  (let* ((port-no (+ (random-integer 20000) 10000))
         (server-sock (socket:udp-server (make-network-endpoint #f port-no)))
         (client-sock (socket:make-udp-client
                       (make-network-endpoint #f 0)
                       (make-network-endpoint "localhost" port-no)))
         (client-outbout-port
          (socket:udp-outbound-write-port client-sock))
         )

    (u8display "ok\n" client-outbout-port)
    (flush-output-port client-outbout-port)

    (let* (;; (msg (read (socket:udp-inbound-read-port server-sock)))
           (msg (socket:udp-read-from server-sock))
           (client-sent (car msg))
           (client-addr (cadr msg))
           (client-host (network-endpoint-host client-addr))
           (client-port (network-endpoint-port client-addr)))
      (socket:udp-write-to "hi\n" server-sock
                           (make-network-endpoint client-host client-port))
      (let* ((msg (socket:udp-read-from client-sock))
             (server-sent (car msg))
             (server-addr (cadr msg))
             (server-host (network-endpoint-host server-addr))
             (server-port (network-endpoint-port server-addr)))
        (socket:udp-close server-sock)
        (socket:udp-close client-sock)
        ;; (cout "port-no=" port-no "\n")
        ;; (cout "client-sent=" client-sent)
        ;; (cout "server-sent=" server-sent)
        (and (equal? client-sent "ok\n")
             (equal? server-sent "hi\n")
             (= port-no server-port))))))


(define (main-program)
  (let ((result #t))
    (cond ((not (test0)) (set! result #f)))
    ;; (cond ((not (test1)) (set! result #f)))
    ;; (cond ((not (test2)) (set! result #f)))
    result))
