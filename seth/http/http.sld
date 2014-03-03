(define-library (seth http)
  (export http
          call-with-request-body
          download-file
          http-header-as-integer
          http-header-as-string)
  (import (scheme base)
          (scheme read)
          (scheme write)
          (scheme char))
  (cond-expand
   (chibi
    (import (chibi io)
            (chibi process)
            (scheme file)
            (chibi net http)))
   (chicken (import (chicken)
                    (ports) ;; for make-input-port
                    (extras) (posix)
                    (http-client)
                    ;; (uri-common)
                    (intarweb)))
   (gauche (import (rfc uri) (rfc http)))
   (sagittarius
    (import (scheme write)
            ;; (rfc uri)
            (match)
            (srfi 1)
            (srfi 13)
            (srfi 14)))
   )
  (import (snow snowlib)
          (snow bytevector)
          (snow srfi-29-format)
          (snow srfi-13-strings)
          (snow extio)
          (seth mime)
          (seth string-read-write)
          (seth uri)
          (seth port-extras)
          (seth network-socket)
          )
  (begin



    (define (http-header-as-integer headers name default)
      (cond ((assq-ref headers name default)
             => (lambda (v)
                  (cond ((number? v) v)
                        ((string? v) (string->number v))
                        (else (snow-error "http-header-as-integer error")))))
            (else #f)))


    (define (http-header-as-string headers name default)
      (cond ((assq-ref headers name default) => ->string)
            (else #f)))


    (define (uri->path-string uri)
      (uri->string
       (update-uri uri 'scheme #f 'authority #f 'fragment #f)))


    ;; (define (path->string path)
    ;;   (string-append
    ;;    "/" (string-join
    ;;         (map uri-encode-string (map ->string (cdr path))) "/")))


    (define (http verb uri writer reader . maybe-user-headers+finalizer)
      ;;
      ;; verb should be a symbol like 'GET
      ;; uri should be a string or a uri record
      ;; writer can be a string or input-port or #f
      ;; reader can be #f or a output-port or (reader input-port headers)
      ;; headers can be #f or an alist or (headers headers-alist)
      ;; --
      ;; if reader is #f return value is
      ;;     (values status-code headers response-body)
      ;; if reader is a procedure, return value is that of reader.
      ;;    reader will be called like this:
      ;;    (reader status-code headers response-body-port)
      ;;
      ;; if writer is a port or procedure and content-length isn't
      ;; among the user-headers, chunked encoding will be used in
      ;; the request.
      ;;
      ;; if optional headers are passed, they should be an alist
      ;; with symbols for keys.
      ;;
      ;; the optional header-finalizer procedure should accept an
      ;; alist of headers (which shouldn't be modified) and return
      ;; an alist of headers.
      ;;
      (define (get-outbound-port-and-length headers)
        (let ((user-content-length
               (http-header-as-integer headers 'content-length #f)))
          ;; XXX should check content-encoding here, in case
          ;; the writer has multi-byte characters
          (cond

           ;; writer is #f
           ((not writer) (values #f 0))

           ;; writer is a string
           ((string? writer)
            (if (and user-content-length
                     (not (= user-content-length
                             (string-length writer))))
                (snow-error "http -- writer string length mismatch"))
            (values (open-input-string writer)
                    (string-length writer)))

           ;; writer is a port
           ((input-port? writer)
            (values writer user-content-length))

           ;; something unexpected
           (else
            (snow-error "http -- invalid writer")))))


      (define (send-body src-port dst-port content-length)
        ;; XXX content-encoding?
        (cond ((not content-length)
               ;; XXX chunked encoding
               (snow-error "http -- request chunked encoding, write me!"))
              (else
               (let loop ((sent 0))
                 (cond ((= sent content-length) #t)
                       (else
                        (let* ((n-to-read (- content-length sent))
                               (n-to-read (if (> n-to-read 300)
                                              300 ;; XXX
                                              n-to-read))
                               (data (read-string n-to-read src-port)))
                          (if (eof-object? data)
                              (snow-error
                               "http -- not enough request body data"))
                          (write-string data dst-port)
                          (loop (+ sent n-to-read)))))))))


      ;; figure out usable versions of all the arguments.  if it's a
      ;; string, parse the url.  supply defaults for unspecified
      ;; optional arguments.
      (let* ((verb-str (string-upcase (->string verb)))
             (uri (cond ((uri-reference? uri) uri)
                        ((string? uri) (uri-reference uri))
                        (else
                         (snow-error "http -- invalid uri" uri))))
             ;; set up network connection
             (hostname (uri-host uri))
             (port (or (uri-port uri)
                       (cond ((eq? (uri-scheme uri) 'http) 80)
                             ((eq? (uri-scheme uri) 'https) 443)
                             (else (snow-error "http -- don't know port")))))
             (sock (open-network-client `((host ,hostname) (port ,port))))
             (write-port (socket:outbound-write-port sock))
             (read-port (socket:inbound-read-port sock))
             ;; path and headers
             ;; (path-part (uri-path-list->path (uri-path uri)))
             ;; (path-part (encode-path (uri-path uri)))
             ;; (path-part (uri-path-list->path (uri-path uri)))
             (path-part (uri->path-string uri))
             (user-headers (if (pair? maybe-user-headers+finalizer)
                               (car maybe-user-headers+finalizer)
                               '()))
             (maybe-user-headers+finalizer
              (if (pair? maybe-user-headers+finalizer)
                  (cdr maybe-user-headers+finalizer) '()))
             (header-finalizer (if (pair? maybe-user-headers+finalizer)
                                   (car maybe-user-headers+finalizer)
                                   (lambda (x) x))))
        ;;
        ;; make request
        ;;
        (let-values (((writer-port content-length)
                      (get-outbound-port-and-length user-headers)))
          ;; finish putting together request headers
          (let* ((host-headers (assq-set user-headers 'host hostname))
                 (host-cl-headers
                  (if content-length
                      (assq-set host-headers 'content-length content-length)
                      host-headers))
                 (final-headers (header-finalizer host-cl-headers)))

            (display
             (with-output-to-string
               (lambda ()
                 ;; send request and headers
                 (display (format "~a ~a HTTP/1.1\r\n" verb-str path-part))
                 (mime-write-headers final-headers (current-output-port))
                 (display "\r\n")))
             write-port)
            ;; send body
            (send-body writer-port write-port content-length)
            (snow-force-output write-port)))

        ;;
        ;; read response
        ;;
        (let* ((first-line (read-line read-port))
               ;; "HTTP/1.1 200 OK"
               (status-code 200) ;; XXX
               (headers (mime-headers->list read-port))
               (content-length
                (http-header-as-integer headers 'content-length 0)))

          ;; XXX check for chunked encoding
          (cond ((not reader)
                 (let ((response-body (read-n content-length read-port)))
                   (values status-code headers response-body)))
                ((procedure? reader)
                 (reader status-code headers read-port))
                ((port? reader)
                 (snow-error "http -- write this!"))
                (else
                 (snow-error "http -- unexpected reader type"))))))



    (cond-expand

     (chicken
      (define (call-with-request-body url reader)
        (call-with-input-request url #f reader))

      (define (download-file url write-port)
        (call-with-request-body
         url
         (lambda (inp)
           (let ((data (read-string #f inp)))
             (write-string data #f write-port)
             (close-output-port write-port)
             #t)))))

     (chibi
      (define (call-with-request-body url consumer)
        (call-with-input-url url consumer))

      ;; (define (call-with-request-body url consumer)
      ;;   (let* ((headers '())
      ;;          (p (http-get url headers))
      ;;          (res (consumer p)))
      ;;     (close-input-port p)
      ;;     res))

      (define (download-file url write-port)
        (call-with-input-url
         url
         (lambda (inp)
           (let loop ()
             (let ((data (read-u8 inp)))
               (cond ((eof-object? data)
                      (close-output-port write-port)
                      #t)
                     (else
                      (write-u8 data write-port)
                      (loop)))))))))

     (gauche
      ;; http://practical-scheme.net/gauche/man/gauche-refe_149.html
      (define (call-with-request-body url consumer)

        (let-values (((scheme user-info hostname port-number
                              path-part query-part fragment-part)
                      (uri-parse url)))
          (let-values (((status-code headers body)
                        (http-get hostname path-part)))
            (consumer (open-input-string body)))))


      (define (download-file url write-port)
        (call-with-request-body
         url
         (lambda (inp)
           (let ((data (read-all-u8 inp)))
             (write-bytevector data write-port)
             (close-output-port write-port)
             #t))))
      )

     (sagittarius
      ;; http://ktakashi.github.io/sagittarius-ref.html#rfc.uri

      (define (call-with-request-body url consumer)
        (http 'GET url #f
              (lambda (status-code headers response-body-port)

                ;; XXX
                (let* ((len (http-header-as-integer headers 'content-length 0))
                       (data (read-n len response-body-port))
                       (p (open-input-string data)))
                  (consumer p))

                )))


      (define (download-file url write-port)
        (call-with-request-body
         url
         (lambda (inp)
           (let* ((data-s (read-all-chars inp))
                  (data-bv (string->latin-1 data-s))
                  )

             ;; (write-bytevector data-bv write-port)
             (let loop ((i 0))
               (cond ((= i (bytevector-length data-bv)) #t)
                     (else
                      (let ((b (bytevector-u8-ref data-bv i)))
                        (write-u8 b write-port)
                        (loop (+ i 1))))))

             (close-output-port write-port)
             #t))))



      ))


    ))
