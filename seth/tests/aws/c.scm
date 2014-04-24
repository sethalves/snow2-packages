#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use amazon-s3)
(use http-client)
(use sha1 message-digest hmac)
(use base64)


(define make-bytevector make-u8vector)
(define bytevector-u8-set! u8vector-set!)

(define (string->latin-1 str)
  ;; XXX this wont work unless it's all ascii.
  (let* ((lst (map char->integer (string->list str)))
         (bv (make-bytevector (length lst))))
    (let loop ((lst lst)
               (pos 0))
      (if (null? lst) bv
          (begin
            (bytevector-u8-set! bv pos (car lst))
            (loop (cdr lst) (+ pos 1)))))))


(write
 ((hmac "Fx2eBfCIyJ1B8zcTWIAr3NTP7MGnpSggI1477eDf" (sha1-primitive))
  "GET\n\napplication/x-www-form-urlencoded\nMon, 14 Apr 2014 01:55:48 GMT\n/"))
(newline)


(write
 (string->latin-1
  ((hmac "Fx2eBfCIyJ1B8zcTWIAr3NTP7MGnpSggI1477eDf" (sha1-primitive))
   "GET\n\napplication/x-www-form-urlencoded\nMon, 14 Apr 2014 01:55:48 GMT\n/")))
(newline)


(write
 (base64-encode
  ((hmac "Fx2eBfCIyJ1B8zcTWIAr3NTP7MGnpSggI1477eDf" (sha1-primitive))
   "GET\n\napplication/x-www-form-urlencoded\nMon, 14 Apr 2014 01:55:48 GMT\n/")))
(newline)


;(access-key "AKIAJNRXXLWGAMRKORNA")
;(secret-key "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")
;(https #f)
;;; (amazon-ns ...)
;(log-http-to-stderr #t)
;
;(write (list-buckets))
;(newline)
