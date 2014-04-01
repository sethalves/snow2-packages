(define-library (seth gensym)
  (export gensym gensym?)
  (import (scheme base))
  (begin

    ;; from gambit
    (define gensym-count 0)

    (define gensym
      (lambda id
        (let ((n gensym-count))
          (set! gensym-count (+ n 1))
          (string->symbol
           (string-append "%%"
                          ;; (if (null? id) "" (symbol->string (car id)))
                          (cond ((null? id) "")
                                ((symbol? (car id)) (symbol->string (car id)))
                                (else (car id)))
                          (number->string n))))))

    (define gensym?
      (lambda (obj)
        (and (symbol? obj)
             (let ((str (symbol->string obj)))
               (and (> (string-length str) 2)
                    (string=? (substring str 0 2) "%%"))))))

    ))
