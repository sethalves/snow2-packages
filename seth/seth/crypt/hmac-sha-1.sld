
;; http://en.wikipedia.org/wiki/Hmac
;; https://github.com/ThomasHintz/chicken-scheme-hmac


(define-library (seth crypt hmac-sha-1)
  (export hmac-sha-1)
  (import (scheme base))
  (cond-expand
   (chicken (import (hmac) (sha1) (snow bytevector)))
   (gauche (import (rfc hmac) (rfc sha) (snow bytevector)))
   (sagittarius
    (import (rfc hmac) (math) (snow bytevector)))
   (else
    (import (snow bytevector)
            (srfi 60)
            (seth port-extras)
            (seth crypt sha-1)
            (scheme write))))
  (begin
    (cond-expand

     (chicken
      (define (hmac-sha-1 key message)
        (string->latin-1
         ((hmac key (sha1-primitive)) message))))


     (gauche
      (define (hmac-sha-1 key message)
        (let* ((key (cond ((bytevector? key) key)
                          ((string? key) (string->utf8 key))
                          ((port? key) (read-all-u8 key))
                          (else
                           (error "unknown hmac-sha-1 key source: " key))))
               (message (cond ((bytevector? message) message)
                              ((string? message) (string->utf8 message))
                              ((port? message) (read-all-u8 message))
                              (else
                               (error "unknown hmac-sha-1 message source: "
                                      message)))))
          (string->latin-1
           (hmac-digest-string
            (latin-1->string message)
            :key (latin-1->string key)
            :hasher <sha1>)))))


     (kawa
      (define (hmac-sha-1 key-in message)
        (let* ((key :: gnu.lists.U8Vector
                    (cond ((bytevector? key-in) key-in)
                          ((string? key-in) (string->utf8 key-in))
                          (else
                           (error "unknown key type: " key-in))))
               (in :: gnu.lists.U8Vector
                   (cond ((bytevector? message) message)
                         ((string? message) (string->utf8 message))
                         ((input-port? message)
                          (error "kawa md5 port write me"))
                         (else (error "unknown digest source: " message))))
               (signing-key :: java.security.Key
                            (javax.crypto.spec.SecretKeySpec
                             (key:getBuffer) "HmacSHA1"))
               (mac :: javax.crypto.Mac
                    (javax.crypto.Mac:getInstance "HmacSHA1")))
          (mac:init signing-key)
          (gnu.lists.U8Vector (mac:doFinal (in:getBuffer))))))


     (sagittarius
      (define (hmac-sha-1 key message)
        (let* ((key (cond ((bytevector? key) key)
                          ((string? key) (string->utf8 key))
                          ((port? key) (read-all-u8 key))
                          (else
                           (error "unknown hmac-sha-1 key source: " key))))
               (message (cond ((bytevector? message) message)
                              ((string? message) (string->utf8 message))
                              ((port? message) (read-all-u8 message))
                              (else
                               (error "unknown hmac-sha-1 message source: "
                                      message)))))
          (hash HMAC message :key key :hash SHA-1))))


     (else
      ;; based on hmac CHICKEN egg by Thomas Hintz
      (define (hmac-sha-1 key message)
        (let* ((key (cond ((bytevector? key) key)
                          ((string? key) (string->utf8 key))
                          ((port? key) (read-all-u8 key))
                          (else
                           (error "unknown hmac-sha-1 key source: " key))))
               (message (cond ((bytevector? message) message)
                              ((string? message) (string->utf8 message))
                              ((port? message) (read-all-u8 message))
                              (else
                               (error "unknown hmac-sha-1 message source: "
                                      message))))
               (block-size 64)
               (key_0 (cond ((> (bytevector-length key) block-size) (sha-1 key))
                            (else key)))
               (key_1 (make-bytevector block-size 0)))
          (bytevector-copy! key_1 0 key_0)

          (let ((ipad (bytevector-map (lambda (c) (bitwise-xor c #x36))
                                      key_1))
                (opad (bytevector-map (lambda (c) (bitwise-xor c #x5c))
                                      key_1)))

            (sha-1
             (bytevector-append
              opad (sha-1 (bytevector-append ipad message)))))))))))
