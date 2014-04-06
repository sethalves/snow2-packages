
;; http://en.wikipedia.org/wiki/Hmac
;; https://github.com/ThomasHintz/chicken-scheme-hmac


(define-library (seth hmac)
  (export hmac-sha1)
  (import (scheme base))
  (cond-expand
   (chibi
    (import (snow bytevector)
            (snow srfi-60-integers-as-bits)
            (snow srfi-13-strings)
            (seth port-extras)
            (seth sha-1)
            (scheme write)
            ))
   (chicken (import (hmac) (sha1) (snow bytevector)))
   (gauche (import (rfc hmac) (rfc sha) (snow bytevector)))
   (sagittarius
    (import (rfc hmac) (math) (snow bytevector))
    ))
  (begin
    (cond-expand

     (chicken
      (define (hmac-sha1 key message)
        (bytes->hex-string
         (string->latin-1
          ((hmac key (sha1-primitive)) message)))))


     (gauche
      (define (hmac-sha1 key message)
        (let* ((key (cond ((bytevector? key) key)
                          ((string? key) (string->utf8 key))
                          ((port? key) (read-all-u8 key))
                          (else
                           (error "unknown sha1-hmac key source: " key))))
               (message (cond ((bytevector? message) message)
                              ((string? message) (string->utf8 message))
                              ((port? message) (read-all-u8 message))
                              (else
                               (error "unknown sha1-hmac message source: "
                                      message)))))

          (bytes->hex-string
           (string->latin-1
            (hmac-digest-string
             (latin-1->string message)
             :key (latin-1->string key)
             :hasher <sha1>))))))


     (sagittarius
      (define (hmac-sha1 key message)
        (let* ((key (cond ((bytevector? key) key)
                          ((string? key) (string->utf8 key))
                          ((port? key) (read-all-u8 key))
                          (else
                           (error "unknown sha1-hmac key source: " key))))
               (message (cond ((bytevector? message) message)
                              ((string? message) (string->utf8 message))
                              ((port? message) (read-all-u8 message))
                              (else
                               (error "unknown sha1-hmac message source: "
                                      message)))))
          (bytes->hex-string
           (hash HMAC message :key key :hash SHA-1)))))


     (else
      ;; based on hmac CHICKEN egg by Thomas Hintz
      (define (hmac-sha1 key message)
        (let* ((key (cond ((bytevector? key) key)
                          ((string? key) (string->utf8 key))
                          ((port? key) (read-all-u8 key))
                          (else
                           (error "unknown sha1-hmac key source: " key))))
               (message (cond ((bytevector? message) message)
                              ((string? message) (string->utf8 message))
                              ((port? message) (read-all-u8 message))
                              (else
                               (error "unknown sha1-hmac message source: "
                                      message))))
               (block-size 64)
               (key_0 (cond ((> (bytevector-length key) block-size)
                             (hex-string->bytes (sha-1 key)))
                            (else key)))
               (key_1 (make-bytevector block-size 0)))
          (bytevector-copy! key_1 0 key_0)

          (let ((ipad (bytevector-map (lambda (c) (bitwise-xor c #x36))
                                      key_1))
                (opad (bytevector-map (lambda (c) (bitwise-xor c #x5c))
                                      key_1)))

            (sha-1
             (bytevector-append
              opad
              (hex-string->bytes
               (sha-1 (bytevector-append ipad message))))))))))))

