#! /bin/sh
#| -*- scheme -*-
exec gsi -:S -e '(load "~~/lib/deflib.scm")' $0 "$@"
|#

#| -*- scheme -*-
exec gsi-script $0 "$@"
|#

#| -*- scheme -*-
exec gsi -:S $0 "$@"
|#




;; (load "/usr/local/Gambit-C/lib/deflib.scm")


;; (import (scheme base) (scheme write) (seth cout))
;; (include "test-common.scm")
;; (display (main-program))
;; (newline)


(define-macro (macro-expand mac)
  (let ((port (gensym))
        (form (gensym))
        (code (gensym)))
    `(let ((,port (open-string)))
       (pp (lambda () ,mac) ,port)
       (let* ((,form (read ,port))
              (,code (cddr ,form)))
         (cond ((null? ,code) '(begin))
               ((null? (cdr ,code)) (car ,code))
               (else `(begin , <at> ,code)))))))



;; (define-syntax while
;;   (syntax-rules ()
;;     ((while condition body ...)
;;      (let loop ()
;;        (if condition
;;            (begin
;;              body ...
;;              (loop))
;;            #f)))))


(display "ok\n")


;; (define x 0)

;; (display
;;  (macro-expand
;;   (while (< x 5)
;;          (set! x (+ x 1))
;;          (display x)
;;          (newline))))

;; (let ((p (open-input-string
;;           "(define-library (seth cout)
;;              (export cout)
;;              (begin (define (cout . items-maybe-port) #t)))")))
;;   (display (read p)))


(define-library (seth cout)
  (export cout)
  (begin
    (definex (cout) #t)))

;; (display
;;  (macro-expand
;;   (import (seth cout))))
