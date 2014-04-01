;;;; message-digest-item.scm
;;;; Kon Lovett, Jan '06 (message-digest.scm)
;;;; Kon Lovett, may '10 (message-digest.scm)
;;;; Kon Lovett, Apr '12

;; Issues

(define-library (seth message-digest item)
  (export message-digest-object
          message-digest-file
          message-digest-port)

  (import
   (scheme base)
   (seth message-digest type)
   (seth message-digest update-item))

(begin

;;; Single Source API

(define (message-digest-object mdp obj
                               ;; #!optional (result-type 'hex)
                               . maybe-result-type
                               )
  (let ((result-type (if (pair? maybe-result-type)
                         (car maybe-result-type)
                         'hex)))
    (let ((md (initialize-message-digest mdp)))
      (message-digest-update-object md obj)
      (finalize-message-digest md result-type) ) ) )

(define (message-digest-file mdp flnm
                             ;; #!optional (result-type 'hex)
                             . maybe-result-type
                             )
  (let ((result-type (if (pair? maybe-result-type)
                         (car maybe-result-type)
                         'hex)))
    (let ((md (initialize-message-digest mdp)))
      (message-digest-update-file md flnm)
      (finalize-message-digest md result-type) ) ) )

(define (message-digest-port mdp port
                             ;; #!optional (result-type 'hex)
                             . maybe-result-type)
  (let ((result-type (if (pair? maybe-result-type)
                         (car maybe-result-type)
                         'hex)))
    (let ((md (initialize-message-digest mdp)))
      (message-digest-update-port md port)
      (finalize-message-digest md result-type) ) ) )

)) ;module message-digest-item
