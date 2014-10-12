(define-library (seth variable-item)
  (export
   ;; warning-guard
   ;; checked-guard
   ;; (define-variable make-variable)
   define-variable
   ;; (define-warning-variable make-variable)
   ;; (define-checked-variable make-variable)
   define-checked-variable
   ;; make-variable
   ;; define-parameter
   ;; define-warning-parameter
   ;; define-checked-parameter
   )
  (import (scheme base)
          (scheme cxr)
          )
  (begin


;; (define-syntax warning-guard
;;   (lambda (frm rnm cmp)
;;     (##sys#check-syntax 'warning-guard frm '(_ symbol symbol . _))
;;     (let ((?getnam (cadr frm))
;;           (?typnam (caddr frm))
;;           (?body (cdddr frm)) )
;;       (let ((predname (string->symbol (string-append (symbol->string ?typnam) "?"))))
;;         `(,(rnm 'lambda) (obj)
;;           (,(rnm 'if) (,predname obj) (,(rnm 'begin) ,@?body obj)
;;             (,(rnm 'begin)
;;               (,(rnm 'warning-argument-type) ',?getnam obj ',?typnam)
;;               (,?getnam) ) ) ) ) ) ) )

;; (define-syntax checked-guard
;;   (lambda (frm rnm cmp)
;;     ;; (##sys#check-syntax 'checked-guard frm '(_ symbol symbol . _))
;;     (let ((?locnam (cadr frm))
;;           (?typnam (caddr frm))
;;           (?body (cdddr frm)) )
;;       (let ((chknam (string->symbol (string-append "check-" (symbol->string ?typnam))))
;;             (body (if (null? ?body) '() (append ?body '(obj)))) )
;;         `(,(rnm 'lambda) (obj)
;;           (,chknam ',?locnam obj)
;;           ,@body ) ) ) ) )

;; ;;

;; ; not too proud of the name `variable' but ...

(define (make-variable init
                       ;; #!optional (guard identity)
                       . maybe-guard
                       )
  (let ((guard (if (pair? maybe-guard)
                   (car maybe-guard)
                   (lambda (x) x))))
    (let ((value (guard init)))
      (define (setter obj) (set! value (guard obj)))
      ;; (getter-with-setter
      ;;  (lambda args
      ;;    (if (null? args) value
      ;;        (setter (car args)) ) )
      ;;  setter)
      (lambda args
        (if (null? args) value
            (setter (car args)) ) )
      ) ) )

(define-syntax define-variable
  (syntax-rules ()
    ((_ ?name ?init) (define ?name (make-variable ?init)) )
    ((_ ?name ?init ?guard) (define ?name (make-variable ?init ?guard)) ) ) )

;; (define-syntax define-warning-variable
;;   (syntax-rules ()
;;     ((_ ?name ?init ?typnam ?body0 ...)
;;       (define-variable ?name ?init (warning-guard ?name ?typnam ?body0 ...)) ) ) )

(define-syntax define-checked-variable
  (syntax-rules ()
    ((_ ?name ?init ?typnam ?body0 ...)
      (define-variable ?name ?init
        ;; (checked-guard ?name ?typnam ?body0 ...)
        ) ) ) )

;; ;;

;; (define-syntax define-parameter
;;   (syntax-rules ()
;;     ((_ ?name ?init) (define ?name (make-parameter ?init)) )
;;     ((_ ?name ?init ?guard) (define ?name (make-parameter ?init ?guard)) ) ) )

;; (define-syntax define-warning-parameter
;;   (syntax-rules ()
;;     ((_ ?name ?init ?typnam ?body0 ...)
;;       (define-parameter ?name ?init (warning-guard ?name ?typnam ?body0 ...)) ) ) )

;; (define-syntax define-checked-parameter
;;   (syntax-rules ()
;;     ((_ ?name ?init ?typnam ?body0 ...)
;;       (define-parameter ?name ?init (checked-guard ?name ?typnam ?body0 ...)) ) ) )


  ))
