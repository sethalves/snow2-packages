;;;; message-digest-port.scm
;;;; Kon Lovett, May '10

;; Issues
;;
;; - Use of sys namespace routines.

(define-library (seth message-digest port)
  (export open-output-digest
          get-output-digest
          call-with-output-digest
          with-output-to-digest
          ;; digest-output-port?
          ;; check-digest-output-port error-digest-output-port
          ;; digest-output-port-name
          )

  (import (scheme base))
  (cond-expand
   (chicken (import (ports)))
   (gauche (import (only (gauche base) port-name)))
   (else))
  (import (srfi 69)
          (seth message-digest type)
          (seth message-digest bv))

  (begin


(define fx- -)

;;; Message Digest Output Port API

;
;; (define (%port-type p) (##sys#slot p 7))
;; (define (%port-type-set! p t) (##sys#setslot p 7 t))
;; (define (%port-name p) (##sys#slot p 3))
;; (define (%port-name-set! p s) (##sys#setslot p 3 s))

;

;; (define (check-open-digest-output-port loc obj)
;;   (##sys#check-port* obj loc) ;must be open
;;   (##sys#check-port-mode obj #f loc)
;;   (unless (eq? 'digest (%port-type obj))
;;     (signal-type-error loc (make-error-type-message 'digest-output-port) obj) ) )

; Synthesize a port-name from a primitive-name

;; (define (make-digest-port-name mdp)
;;   (let ((nam (->string (or (message-digest-primitive-name mdp) 'digest))))
;;     (let ((remlen (string-suffix-length-ci nam "-primitive")))
;;       (string-append
;;        "("
;;        (if (positive? remlen)
;;            (substring nam 0 (fx- (string-length nam) remlen))
;;            nam )
;;        ")") ) ) )

;; Returns a digest-output-port for the MDP


(define (port->hash-key port)
  (cond-expand
   (gauche (port-name port))
   (else port)))

(define port->data (make-hash-table eq?))
(define (set-port-data! port data)
  (hash-table-set! port->data (port->hash-key port) data))
(define (delete-port-data! port)
  (hash-table-delete! port->data (port->hash-key port)))
(define (port-data port)
  (hash-table-ref port->data (port->hash-key port)))


(cond-expand
 (chicken
  (define (open-output-digest mdp)
    (let* ((md (initialize-message-digest mdp))
           (writer (lambda (obj)
                     ;; It will only ever be a string for now.
                     (if (string? obj) (message-digest-update-string md obj)
                         (message-digest-update-blob md obj))))
           (port (make-output-port writer (lambda () #t))))
      (set-port-data! port md)
      port)))

 (else
  (define (open-output-digest mdp)
    (let ((md (initialize-message-digest mdp))
          (port (open-output-bytevector)))
      (set-port-data! port md)
      port))))


;; (define (digest-output-port? obj)
;;   (and (output-port? obj)
;;        (eq? 'digest (%port-type obj)) ) )

;; (define-check+error-type digest-output-port)

;; (define (digest-output-port-name p)
;;   (check-digest-output-port 'digest-output-port-name p)
;;   (%port-name p) )

;; Finalizes the digest-output-port and returns the result in the form requested


(cond-expand

 (chicken
  (define (*close-output-digest loc digest-port result-type)
    ;; (check-open-digest-output-port loc digest-port)
    (let ((res (finalize-message-digest (port-data digest-port) result-type)))
      (delete-port-data! digest-port)
      (close-output-port digest-port)
      res)))

 (else
  (define (*close-output-digest loc digest-port result-type)
    (let ((md (port-data digest-port))
          (data (get-output-bytevector digest-port)))
      (message-digest-update-blob md data)
      (let ((res (finalize-message-digest md result-type)))
        (delete-port-data! digest-port)
        (close-output-port digest-port)
        res)))))




(define (get-output-digest digest-port
                           ;; #!optional (result-type 'hex)
                           . maybe-result-type
                           )
  (let ((result-type (if (pair? maybe-result-type)
                         (car maybe-result-type)
                         'hex)))
    (*close-output-digest 'get-output-digest digest-port result-type) ) )

;;;

;; Calls the procedure PROC with a single argument that is a digest-output-port for the MDP.
;; Returns the accumulated output string | blob | u8vector | hexstring

(define (call-with-output-digest mdp proc
                                 ;; #!optional (result-type 'hex)
                                 . maybe-result-type
                                 )
  (let ((result-type (if (pair? maybe-result-type)
                         (car maybe-result-type)
                         'hex)))
    (let ((port (open-output-digest mdp)))
      (proc port)
      (*close-output-digest 'call-with-output-digest port result-type) ) ) )

;; Calls the procedure THUNK with the current-input-port temporarily bound to a
;; digest-output-port for the MDP.
;; Returns the accumulated output string | blob | u8vector | hexstring

(define (with-output-to-digest mdp thunk
                               ;; #!optional (result-type 'hex)
                               . maybe-result-type
                               )
  (let ((result-type (if (pair? maybe-result-type)
                         (car maybe-result-type)
                         'hex)))
    (call-with-output-digest
     mdp
     ;; (cut with-input-from-port <> thunk)
     (lambda (port)
       (let ((save-current-input-port (current-input-port)))
         (current-input-port port)
         (thunk)
         (current-input-port save-current-input-port)))
     result-type) ) )

)) ;module message-digest
