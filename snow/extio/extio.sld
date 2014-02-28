(define-library (snow extio)
  (export snow-read-string
          snow-force-output
          snow-pretty-print)
  (import (scheme base) (scheme write))
  (cond-expand
   (chibi (import (chibi io)))
   (chicken (import (only (chicken) flush-output pretty-print)))
   (gauche (import (snow gauche-extio-utils)))
   (sagittarius))
  (begin

    (cond-expand

     ;; snow-read-string is like r7rs read-string except that
     ;; if the length is #f, it will read until eof (like CHICKEN's).

     ((or chicken)
      (define snow-read-string read-string))

     ((or chibi gauche sagittarius)
      (define (read-string-until-eof port)
        (let loop ((strings '()))
          (let ((s (read-string 4000 port)))
            (cond ((eof-object? s)
                   (apply string-append (reverse strings)))
                  (else
                   (loop (cons s strings)))))))

      (define (snow-read-string len port)
        (if (not len)
            (read-string-until-eof port)
            (read-string len port))))
     )


    (cond-expand

     ((or bigloo
          chibi
          larceny
          chez
          sagittarius
          sisc
          stklos)

      (define (snow-force-output . maybe-port)
        (let ((port (if (null? maybe-port) (current-output-port)
                        (car maybe-port))))
          (flush-output-port port))))

     ((or gambit
          guile
          kawa
          scheme48
          scm
          scsh)

      (define (snow-force-output . maybe-port)
        (let ((port (if (null? maybe-port) (current-output-port)
                        (car maybe-port))))
          (force-output port))))

     ((or chicken
          mit
          mzscheme)

      (define (snow-force-output . maybe-port)
        (let ((port (if (null? maybe-port) (current-output-port)
                        (car maybe-port))))
          (flush-output port))))

     (gauche
      ;; See gauche-extio-utils.sld
      ;; this was done to get access to flush
      ;; (define (snow-force-output . maybe-port)
      ;;   (let ((port (if (null? maybe-port) (current-output-port)
      ;;                   (car maybe-port))))
      ;;     (flush port)))
      )
     )

    (cond-expand

     ((or bigloo
          mit)

      (define (snow-pretty-print obj . maybe-port)
        (let ((port (if (null? maybe-port) (current-output-port)
                        (car maybe-port))))
          (pp obj port))))

     ((or chez
          ;; chicken -- XXX how to get pretty-print into r7rs library?
          gambit
          mzscheme
          petite
          scm)

      (define (snow-pretty-print obj . maybe-port)
        (let ((port (if (null? maybe-port) (current-output-port)
                        (car maybe-port))))
          (pretty-print obj port))))

     ((or scheme48
          scsh)

      (define (snow-pretty-print obj . maybe-port)
        (let ((port (if (null? maybe-port) (current-output-port)
                        (car maybe-port))))
          (pretty-print obj port 0)
          (newline port))))

     (stklos

      (define (snow-pretty-print obj . maybe-port)
        (let ((port (if (null? maybe-port) (current-output-port)
                        (car maybe-port))))
          (pretty-print obj port: port))))

     (else

      (define (snow-pretty-print obj . maybe-port)
        (let ((port (if (null? maybe-port) (current-output-port)
                        (car maybe-port))))
          (write obj port)
          (newline port)))))

    ))
