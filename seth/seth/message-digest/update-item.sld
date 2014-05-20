;;;; message-digest-update-item.scm
;;;; Kon Lovett, Jan '06 (message-digest.scm)
;;;; Kon Lovett, May '10 (message-digest.scm)
;;;; Kon Lovett, Apr '12

;; Issues

(define-library (seth message-digest update-item)
  (export message-digest-update-object
          message-digest-update-procedure
          message-digest-update-port
          message-digest-update-file
          )

  (import
   (scheme base)
   (scheme file)
   (snow snowlib)
   ;; (snow bytevector)
   (seth message-digest parameters)
   (seth message-digest primitive)
   (seth message-digest type)
   ;; (seth message-digest support)
   )

(begin

;;; Support

;;

(define (chunk-convert obj)
  (let ((cnv (message-digest-chunk-converter)))
    (cond ((cnv (cnv obj))))))

(define (get-chunk-reader in)
  ((message-digest-chunk-read-maker) in))

(define (get-update md)
  (message-digest-primitive-update (message-digest-algorithm md)))

;;

;; (define (object->bytevector-like obj)
;;   (or (packed-vector->blob/shared obj)
;;       (chunk-convert obj)))
(define (object->bytevector-like obj)
  (cond ((bytevector? obj)
         (chunk-convert obj))
        (else #f)))

(define (do-byte-source-update loc ctx src updt)
  (cond
   ;; simple bytes
   ((bytevector? src)
    (updt ctx src (bytevector-length src)))
   ((string? src)
    (do-byte-source-update loc ctx (string->utf8 src) updt))
   ;; more complicated bytes
   ((object->bytevector-like src) =>
    ;; (cut do-byte-source-update loc ctx <> updt)
    (lambda (x) (do-byte-source-update loc ctx x updt)))
   ;; too complicated bytes
   (else
    (snow-error "indigestible object" loc src))))

(define (do-procedure-update loc md proc)
  (let ((updt (get-update md))
        (ctx (message-digest-context md)) )
    ;; (while* (proc) (do-byte-source-update loc ctx it updt))
    (let loop ()
      (let ((it (proc)))
        (cond (it (do-byte-source-update loc ctx it updt)
                  (loop)))))))

(define (do-port-update loc md in)
  (do-procedure-update loc md (get-chunk-reader in)) )

(define (do-bytes-update loc md src)
  (let ((updt (get-update md))
        (ctx (message-digest-context md)) )
    (do-byte-source-update loc ctx src updt) ) )

(define (do-object-update loc md src)
  (cond
    ((input-port? src)    (do-port-update loc md src) )
    ((procedure? src)     (do-procedure-update loc md src) )
    (else                 (do-bytes-update loc md src) ) ) )

;;; Update Operation

;;

(define (message-digest-update-object md obj)
  ;; (check-message-digest 'message-digest-update-object md)
  (do-object-update 'message-digest-update-object md obj) )

;;

(define (message-digest-update-procedure md proc)
  ;; (check-message-digest 'message-digest-update-procedure md)
  ;; (check-procedure 'message-digest-update-procedure proc)
  (do-procedure-update 'message-digest-update-procedure md proc) )

;;

(define (message-digest-update-port md in)
  ;; (check-message-digest 'message-digest-update-port md)
  ;; (check-input-port 'message-digest-update-port in)
  (do-port-update 'message-digest-update-port md in) )

;;

;; (define (message-digest-update-file md flnm)
;;   ;; (check-message-digest 'message-digest-update-file md)
;;   ;; (check-string 'message-digest-update-file flnm)
;;   (let ((in (open-input-file flnm)))
;;     (handle-exceptions exn
;;         (begin (close-input-port in) (abort exn))
;;       (do-port-update 'message-digest-update-file md in) )
;;     (close-input-port in) ) )


;; (define (message-digest-update-file md flnm)
;;   (check-message-digest 'message-digest-update-file md)
;;   (check-string 'message-digest-update-file flnm)
;;   (let ((in #f))
;;   	(dynamic-wind
;;   		(lambda () (set! in (open-input-file flnm)) )
;;   		(lambda () (do-port-update 'message-digest-update-file md in) )
;;     	(lambda () (close-input-port in) ) ) ) )

;; )



(define (message-digest-update-file md flnm)
  ;; (check-message-digest 'message-digest-update-file md)
  ;; (check-string 'message-digest-update-file flnm)
  (let ((in (open-input-file flnm)))
    (with-exception-handler
     (lambda (exn)
       (close-input-port in)
       (snow-error "message-digest-update-file" exn))
     (lambda ()
       (do-port-update 'message-digest-update-file md in)))
    (close-input-port in) ) )

;;module message-digest-update-item
))
