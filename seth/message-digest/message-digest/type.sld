;;;; message-digest-type.scm
;;;; Kon Lovett, Jan '06 (message-digest.scm)
;;;; Kon Lovett, May '10 (message-digest.scm)
;;;; Kon Lovett, Apr '12

;; Issues
;;
;; - Uses 'context-info' to determine whether active context is "own" allocation or
;; callers.



(define-library (seth message-digest type)

  (export
   message-digest?
   ;; check-message-digest error-message-digest
   message-digest-algorithm message-digest-context
   initialize-message-digest
   finalize-message-digest
   setup-message-digest-buffer!)

  (import (scheme base)
          (snow snowlib)
          (snow bytevector)
          (seth message-digest primitive)
          )

(begin

;;; Support

(define MINIMUM-BUFFER-SIZE 8)
(define fxmax max)
(define fx<= <=)
(define number-of-bytes bytevector-length)
(define make-blob make-bytevector)
(define blob->hex bytes->hex-string)
(define (blob->u8vector/shared b) b)
(define blob->string utf8->string)

(define (error-result-form loc obj)
  ;; (error-argument-type loc obj "symbol in {string hex blob u8vector}" 'result-form)
  (snow-error "result-form -- symbol in {string hex blob u8vector}" loc obj)
  )

;perform any conversion necessary for final result representation
;assumes blob 'res' may not be of result size
;; (define (get-result-form loc res rt len)
;;   (case rt
;;     ((blob)
;;       (if (fx= len (blob-size res)) res
;;         (string->blob (substring (blob->string res) 0 len)) ) )
;;     ((string byte-string)
;;       (let ((str (blob->string res)))
;;         (if (fx= len (string-length str)) str
;;           (substring str 0 len) ) ) )
;;     ((hexstring hex)
;;       (blob->hex res 0 len) )
;;     ((u8vector)
;;       (let ((vec (blob->u8vector/shared res)))
;;         (if (fx= len (u8vector-length vec)) vec
;;           (subu8vector vec 0 len) ) ) )
;;     (else
;;       (error-result-form loc rt) ) ) )

;perform any conversion necessary for final result representation
;assumes blob 'res' is of result size
(define (get-result-form loc res rt)
  (case rt
    ((blob)                     res )
    ((string byte-string)       (blob->string res) )
    ((hexstring hex)            (blob->hex res) )
    ((u8vector)                 (blob->u8vector/shared res) )
    (else
      ;; (error-result-form loc rt)
     (snow-error "(message-digest type) unexpected return type" loc rt)
      ) ) )


;;; Message Digest API

;;

(define-record-type message-digest
  (*make-message-digest mdp ctx buf)
  message-digest?
  (mdp message-digest-algorithm)
  (ctx message-digest-context)
  (buf message-digest-buffer message-digest-buffer-set!) )

;; (define-check+error-type message-digest)

;;

(define (get-message-digest-primitive-context mdp)
  (let ((ctx-info (message-digest-primitive-context-info mdp)))
    (if (procedure? ctx-info) (ctx-info)
        (begin
          ;; (set-finalizer! (allocate ctx-info) free)
          (snow-error "can't do set-finalizer! here.")
          )
        ) ) )

;;

(define (initialize-message-digest mdp)
  ;; (check-message-digest-primitive 'initialize-message-digest mdp)
  (let ((ctx (get-message-digest-primitive-context mdp)))
    ((message-digest-primitive-init mdp) ctx)
    (*make-message-digest mdp ctx #f) ) )

;;

(define (finalize-message-digest md
                                 ;; #!optional (result-type 'hex)
                                 . maybe-result-type
                                 )
  (let ((result-type (if (pair? maybe-result-type)
                         (car maybe-result-type)
                         'hex)))
    ;; (check-message-digest 'finalize-message-digest md)
    (let ((mdp (message-digest-algorithm md))
          (ctx (message-digest-context md)) )
      (let ((res (make-blob (message-digest-primitive-digest-length mdp))))
        ((message-digest-primitive-final mdp) ctx res)
        (get-result-form 'finalize-message-digest res result-type) ) ) ) )

;;

(define (setup-message-digest-buffer! md sz)
  (let ((buf (message-digest-buffer md))
        (sz (fxmax sz MINIMUM-BUFFER-SIZE)) )
    (if (and buf (fx<= sz (number-of-bytes buf))) buf
      (let ((buf (make-blob sz)))
        (message-digest-buffer-set! md buf)
        buf ) ) ) )

))
