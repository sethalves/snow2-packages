;;;; message-digest-parameters.scm
;;;; Kon Lovett, Jan '06 (message-digest.scm)
;;;; Kon Lovett, May '10 (message-digest.scm)
;;;; Kon Lovett, Apr '12

;; Issues
;;
;; - Uses 'context-info' to determine whether active context is "own" allocation or
;; callers. Again, a kludge.
;;
;; - Passes u8vector to update phase as a blob.

(define-library (seth message-digest parameters)
  (export
   message-digest-chunk-size
   message-digest-chunk-read-maker
   message-digest-chunk-converter)

  (import (scheme base)
          (seth variable-item)
          )

(begin

;;; Update Phase Helpers

(define fx= =)

;;

(define (default-chunk-read-maker in
          ;; #!optional (size (message-digest-chunk-size))
          . maybe-size
          )
  (let ((size (if (pair? maybe-size)
                  (car maybe-size)
                  (message-digest-chunk-size))))
    (lambda ()
      (read-bytevector size in))

    ;; (let ((u8buf (make-bytevector size)))
    ;;   (lambda ()
    ;;     (let ((len
    ;;            ;; (read-u8vector! size u8buf in)
    ;;            (read-bytevector! u8buf in 0 size)
    ;;            ))
    ;;       (and (positive? len)
    ;;            (let ((u8buf (if (fx= len size)
    ;;                             u8buf
    ;;                             (bytevector-copy u8buf 0 len))))
    ;;              ;; (u8vector->blob/shared u8buf)
    ;;              u8buf
    ;;              ) ) ) ) )
    ) )

;;

(define DEFAULT-CHUNK-SIZE 1024)

;;; Message Digest "Parameters"

;;

;; (define-checked-variable message-digest-chunk-size
;;   DEFAULT-CHUNK-SIZE
;;   positive-fixnum)

(define message-digest-chunk-size
  (let ((v DEFAULT-CHUNK-SIZE))
    (lambda args
      (cond ((null? args) v)
            (else (set! v (car args))
                  v)))))


;;

;; (define-checked-variable message-digest-chunk-read-maker
;;   default-chunk-read-maker
;;   procedure)

(define-variable message-digest-chunk-read-maker
  default-chunk-read-maker)


;; (define message-digest-chunk-read-maker
;;   (let ((v default-chunk-read-maker))
;;     (lambda args
;;       (cond ((null? args) v)
;;             (else (set! v (car args))
;;                   v)))))

;;

;; (define-variable message-digest-chunk-converter #f
;;   (lambda (obj)
;;     (if (or (not obj) (procedure? obj)) obj
;;       (error-argument-type 'message-digest-chunk-converter obj "#f or procedure"))))


(define message-digest-chunk-converter
  (let ((v #f))
    (lambda args
      (cond ((null? args) v)
            (else (set! v (car args))
                  v)))))

)) ;module message-digest-parameters
