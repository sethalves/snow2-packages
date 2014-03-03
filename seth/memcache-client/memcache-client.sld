;; -*- scheme -*-
;; https://github.com/memcached/memcached/blob/master/doc/protocol.txt

(define-library (seth memcache-client)
  (export connect
          disconnect
          set-entry!
          add-entry!
          replace-entry!
          append-to-entry!
          prepend-to-entry!
          update-entry!
          cas-entry!
          get-entry
          get-entries
          incr!
          decr!
          delete-entry!
          stats)
  (import (scheme base) (scheme read) (scheme write))
  (cond-expand
   (chibi (import (only (chibi string) string-split)))
   (chicken (import (memcached)))
   (gauche)
   (sagittarius)
   (else))
  (import (snow bytevector)
          (snow srfi-13-strings)
          (seth network-socket)
          (seth string-read-write)
          (seth port-extras)
          (seth base64))
  (begin

    (cond-expand

     ((or chibi gauche sagittarius)
      (define-record-type <memcache-connection>
        (make-memcache-connection
         socket read-port write-port
         key-encoder key-decoder value-encoder value-decoder)
        memcache-connection?
        (socket memcache-connection-socket
                memcache-connection-set-socket!)
        (read-port memcache-connection-read-port
                   memcache-connection-set-read-port!)
        (write-port memcache-connection-write-port
                    memcache-connection-set-write-port!)
        (key-encoder memcache-connection-key-encoder
                     memcache-connection-set-key-encoder!)
        (key-decoder memcache-connection-key-decoder
                     memcache-connection-set-key-decoder!)
        (value-encoder memcache-connection-value-encoder
                       memcache-connection-set-value-encoder!)
        (value-decoder memcache-connection-value-decoder
                       memcache-connection-set-value-decoder!)
        )


      (define (connect server-name server-port . coders)
        (let ((key-encoder
               (if (> (length coders) 0) (list-ref coders 0) encode-string))
              (key-decoder
               (if (> (length coders) 1) (list-ref coders 1) decode-string))
              (value-encoder
               (if (> (length coders) 2) (list-ref coders 2) write-to-string))
              (value-decoder
               (if (> (length coders) 3) (list-ref coders 3) read-from-string))
              (sock (open-network-client `((host "localhost")
                                           (port ,server-port))))
              )
          (make-memcache-connection
           sock
           (socket:inbound-read-port sock)
           (socket:outbound-write-port sock)
           key-encoder key-decoder value-encoder value-decoder)))


      (define (disconnect mc-conn)
        (socket:close (memcache-connection-socket mc-conn)))


      (define (store! mc-conn command key flags expires value)
        (let* ((key-encoded
                ((memcache-connection-key-encoder mc-conn) key))
               (value-encoded
                ((memcache-connection-value-encoder mc-conn) value))
               (rport (memcache-connection-read-port mc-conn))
               (wport (memcache-connection-write-port mc-conn))
               (command (string-append
                         command " "
                         key-encoded " "
                         (number->string flags) " "
                         (number->string expires) " "
                         (number->string (string-length value-encoded))
                         "\r\n" value-encoded "\r\n")))
          (write-string command wport)
          (flush-output-port wport)
          (let ((response (read-line rport)))
            ;; "STORED\r\n", to indicate success.
            ;; "NOT_STORED\r\n" to indicate the data was not stored, but not
            ;;     because of an error. This normally means that the
            ;;     condition for an "add" or a "replace" command wasn't met.
            ;; "EXISTS\r\n" to indicate that the item you are trying to store
            ;;     with a "cas" command has been modified since you last
            ;;     fetched it.
            ;; "NOT_FOUND\r\n" to indicate that the item you are trying
            ;;     to store with a "cas" command did not exist.
            (cond ((equal? response "STORED") #t)
                  ((equal? response "NOT_STORED") 'not-stored)
                  ((equal? response "EXISTS") 'exists)
                  ((equal? response "NOT_FOUND") 'not-found)
                  (else
                   (error "bad store! memcache response: "
                          (write-to-string response)))))))

      (define (stats mc-conn)
        (let ((rport (memcache-connection-read-port mc-conn))
              (wport (memcache-connection-write-port mc-conn)))
          (write-string "stats\r\n" wport)
          (flush-output-port wport)
          (let loop ((stats '()))
            (let ((response (read-line rport)))
              (cond ((equal? response "END") (reverse stats))
                    ((string-prefix? "STAT " response)
                     (let* ((stat (substring response 5
                                             (string-length response)))
                            (stat-parts
                             (cond-expand
                              (chibi (string-split stat #\space))
                              (else (string-tokenize stat)))))
                       (loop (cons stat-parts stats))))
                    (else #f))))))


      (define (set-entry! mc-conn key flags expires value)
        (store! mc-conn "set" key flags expires value))


      (define (add-entry! mc-conn key flags expires value)
        (store! mc-conn "add" key flags expires value))


      (define (replace-entry! mc-conn key flags expires value)
        (store! mc-conn "replace" key flags expires value))


      (define (append-to-entry! mc-conn key value)
        (store! mc-conn "append" key 0 0 value))


      (define (prepend-to-entry! mc-conn key value)
        (store! mc-conn "prepend" key 0 0 value))


      (define (cas-entry! mc-conn key flags expires value cas-unique)
        ;; cas <key> <flags> <exptime> <bytes> <cas unique> [noreply]\r\n
        (let* ((key-encoded ((memcache-connection-key-encoder mc-conn) key))
               (value-encoded
                ((memcache-connection-value-encoder mc-conn) value))
               (rport (memcache-connection-read-port mc-conn))
               (wport (memcache-connection-write-port mc-conn))
               (command (string-append
                         "cas "
                         key-encoded " "
                         (number->string flags) " "
                         (number->string expires) " "
                         (number->string (string-length value-encoded)) " "
                         cas-unique
                         "\r\n" value-encoded "\r\n")))
          (write-string command wport)
          (flush-output-port wport)
          (let ((response (read-line rport)))
            (cond ((equal? response "STORED") #t)
                  ((equal? response "NOT_STORED") 'not-stored)
                  ((equal? response "EXISTS") 'exists)
                  ((equal? response "NOT_FOUND") 'not-found)
                  (else
                   (error "bad cas-entry! memcache set response: "
                          (write-to-string response)))))))


      (define (incr/decr mc-conn command key value)
        (let* ((key-encoded ((memcache-connection-key-encoder mc-conn) key))
               (value-encoded
                (if (string? value) value (number->string value)))
               (rport (memcache-connection-read-port mc-conn))
               (wport (memcache-connection-write-port mc-conn))
               (command (string-append command " " key-encoded " "
                                       value-encoded "\r\n")))
          (write-string command wport)
          (flush-output-port wport)
          (let ((response (read-line rport)))
            (cond ((equal? response "NOT_FOUND") #f)
                  (else
                   (string->number response))))))

      (define (incr! mc-conn key value)
        (incr/decr mc-conn "incr" key value))


      (define (decr! mc-conn key value)
        (incr/decr mc-conn "decr" key value))


      (define (get-entries mc-conn keys)
        (let* ((keys-encoded
                (map (memcache-connection-key-encoder mc-conn) keys))
               (command
                (string-append "gets " (string-join keys-encoded " ") "\r\n"))
               (rport (memcache-connection-read-port mc-conn))
               (wport (memcache-connection-write-port mc-conn)))
          (write-string command wport)
          (flush-output-port wport)

          (let loop ((result '()))
            (let* ((response (read-line rport))
                   (response-parts (cond-expand
                                    (chibi (string-split response #\space))
                                    (else (string-tokenize response))))
                   (parts-count (length response-parts)))
              (cond ((equal? (car response-parts) "END") (reverse result))
                    ((equal? (car response-parts) "VALUE")
                     (let* ((keyd (memcache-connection-key-decoder mc-conn))
                            (vald (memcache-connection-value-decoder mc-conn))
                            (response-key-encoded (list-ref response-parts 1))
                            (response-flags (list-ref response-parts 2))
                            (response-len (list-ref response-parts 3))
                            (response-cas (list-ref response-parts 4))
                            (data (read-n (string->number response-len) rport))
                            (blank (read-line rport)))
                       (loop (cons (list (keyd response-key-encoded)
                                         response-flags
                                         (vald data)
                                         response-cas)
                                   result))))
                    (else
                     (error "bad memcache get response: "
                            (write-to-string response) "\n")))))))


      (define (get-entry mc-conn key)
        (let ((result (get-entries mc-conn (list key))))
          (cond ((null? result) #f)
                (else (list-ref (car result) 2)))))


      (define (delete-entry! mc-conn key)
        (let* ((key-encoded
                ((memcache-connection-key-encoder mc-conn) key))
               (command (string-append "delete " key-encoded "\r\n"))
               (rport (memcache-connection-read-port mc-conn))
               (wport (memcache-connection-write-port mc-conn)))
          (write-string command wport)
          (flush-output-port wport)
          (let ((response (read-line rport)))
            (cond ((equal? response "DELETED") #t)
                  ((equal? response "NOT_FOUND") #f)
                  (else
                   (error "bad memcache delete response: "
                          (write-to-string response)))))))


      (define (close mc-conn)
        (socket:close (memcache-connection-socket mc-conn))))



     (chicken
      ;; (define connect connect)
      ;; (define disconnect disconnect)
      (define get-entries gets)
      (define get-entry get)

      (define (set-entry! mc-conn key flags expires value)
        (set mc-conn key value flags: flags expires: expires))

      (define (add-entry! mc-conn key flags expires value)
        (add mc-conn key value flags: flags expires: expires))

      (define (replace-entry! mc-conn key flags expires value)
        (replace mc-conn key value flags: flags expires: expires))

      (define (cas-entry! mc-conn key flags expires value cas-unique)
        (cas mc-conn key value cas-unique flags: flags expires: expires))

      (define (append-to-entry! mc-conn key value)
        ;; memcached ignores flags and exptime for append
        (append-to mc-conn key value))

      (define (prepend-to-entry! mc-conn key value)
        ;; memcached ignores flags and exptime for prepend
        (prepend-to mc-conn key value))

      (define incr! incr)
      (define decr! decr)
      (define delete-entry! delete)
      )
     )

    (cond-expand
     ((or chicken chibi gauche sagittarius)
      (define (update-entry! mc-conn key flags expires updater-func)
        ;; convenience function to update an entry that may
        ;; have more than one writer.  updater-func should
        ;; take the existing data as its argument and return
        ;; new data.  it may be called more than once.
        (let loop ()
          (define (attempt-add)
            (let* ((new-entry (updater-func #f))
                   (add-result
                    (add-entry! mc-conn key flags expires new-entry)))
              (cond ((eq? add-result #t) #t)
                    ((eq? add-result 'not-stored) (loop))
                    ((eq? add-result 'exists) (loop))
                    ((eq? add-result 'not-found) (loop))
                    (else (error "something unexpected.")))))
          (let ((gets-result (get-entries mc-conn (list key))))
            (cond ((null? gets-result)
                   (attempt-add))
                  (else
                   (let* ((result (car gets-result))
                          (entry-key-encoded (list-ref result 0))
                          (entry-flags (list-ref result 1))
                          (entry-value (list-ref result 2))
                          (entry-cas-unique (list-ref result 3))
                          (new-entry (updater-func entry-value))
                          (cas-result (cas-entry! mc-conn key flags expires
                                                  new-entry entry-cas-unique)))
                     (cond ((eq? cas-result #t) #t)
                           ((eq? cas-result 'lost-race) (loop))
                           ((eq? cas-result 'not-found)
                            (attempt-add))
                           (else (error "something else unexpected.")))))))))))
    ))
