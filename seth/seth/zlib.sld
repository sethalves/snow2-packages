(define-library (seth zlib)
  (export
   ;; these handle rfc-1951, not rfc-1950
   ;; output-port->deflating-genport
   input-port->deflating-port
   input-port->inflating-port
   )
  (import (scheme base))
  (cond-expand
   (chibi (import (snow genport)
                  (snow zlib)))
   (chicken (import (srfi 1)
                    (ports)
                    (z3)
                    (snow bytevector)
                    (snow genport)
                    (seth port-extras)))
   (gauche
    (import (rfc zlib)
            (seth port-extras)))
   (sagittarius
    (import (rfc zlib))
    (import (seth port-extras))))
  (begin
    (cond-expand

     (chicken

      ;; http://wiki.call-cc.org/eggref/4/z3

      ;; (define (reverse-string-list->string str-lst)
      ;;   ;; reverse a list of strings and combine them into
      ;;   ;; a single string
      ;;   (let* ((data-size (fold + 0 (map string-length str-lst)))
      ;;          (result (make-string data-size)))
      ;;     (let loop ((str-lst str-lst)
      ;;                (result-i data-size))
      ;;       (cond ((null? str-lst) result)
      ;;             (else
      ;;              (let* ((str (car str-lst))
      ;;                     (new-result-i (- result-i (string-length str))))
      ;;                (string-copy! result new-result-i str)
      ;;                (loop (cdr str-lst) new-result-i)))))))

      ;; (define (output-port->deflating-genport outp)
      ;;   (let ((segments '()))
      ;;     (genport-native-output-port->genport
      ;;      (make-output-port
      ;;       (lambda (str) ;; write
      ;;         (set! segments (cons str segments)))
      ;;       (lambda () ;; close
      ;;         (let ((data (string->latin-1
      ;;                      (z3:encode-buffer
      ;;                       (reverse-string-list->string segments)))))
      ;;           (write-bytevector data outp)
      ;;           (close-output-port outp)))))))

      (define (input-port->deflating-port inp)
        (let* ((bv (read-all-u8 inp))
               (str (latin-1->string bv)))
          (open-input-string (z3:encode-buffer str))))


      (define (input-port->inflating-port inp)
        (let* ((bv (read-all-u8 inp))
               (str (latin-1->string bv)))
          (open-input-string (z3:decode-buffer str)))))



     (gauche
     ;; http://practical-scheme.net/gauche/man/gauche-refe_158.html#Operations-on-inflating_002fdeflating-ports
      ;; (define (output-port->deflating-genport outp)
      ;;  (open-deflating-port outp))

      (define (input-port->deflating-port inp)
        (let* ((bv-plain (read-all-u8 inp))
               (out (open-output-bytevector))
               (def-port (open-deflating-port
                          out
                          :window-bits -15
                          :compression-level Z_BEST_COMPRESSION)))
          (write-bytevector bv-plain def-port)
          (close-output-port def-port)
          (open-input-bytevector (get-output-bytevector out))))

      (define (input-port->inflating-port inp)
        (open-inflating-port inp :window-bits -15)
        )
      )

     ;; (sagittarius
     ;;  (define (output-port->deflating-genport outp)
     ;;    (open-deflating-output-port outp))
     ;;  (define (input-port->inflating-port inp)
     ;;    (open-inflating-input-port inp)))


     (sagittarius
      ;; http://ktakashi.github.io/sagittarius-ref.html#rfc.zlib
      (define (input-port->deflating-port inp)
        (let* ((bv-plain (read-all-u8 inp))
               (out (open-output-bytevector))
               (def-port (open-deflating-output-port
                          out
                          :window-bits -15
                          :compression-level Z_BEST_COMPRESSION)))
          (write-bytevector bv-plain def-port)
          (close-output-port def-port)
          (open-input-bytevector (get-output-bytevector out))))

      (define (input-port->inflating-port inp)
        (open-inflating-input-port inp :window-bits -15)
        ))

     (else

      (define (input-port->deflating-port inp)
        (genport->binary-input-port
         (deflate-genport
           (genport-native-input-port->genport inp))))

      (define (input-port->inflating-port inp)
        (genport->binary-input-port
         (inflate-genport
          (genport-native-input-port->genport
           inp))))))))
