;;;============================================================================

;;; File: "binio.scm", Time-stamp: <2007-09-03 13:21:13 feeley>

;;; Copyright (c) 2006-2007 by Marc Feeley, All Rights Reserved.

;;;============================================================================

;;; Provides procedures to do binary I/O, including a subset of SRFI 91.


(define-library (snow binio)
  (export binio-open-input-file
          binio-open-output-file
          binio-read-subu8vector
          binio-write-subu8vector
          write-latin-1-string
          read-latin-1-char
          peek-latin-1-char
          read-latin-1-line
          )
  (import (scheme base) (scheme file))
  (cond-expand
   (chibi)
   (chicken)
   (gauche (import (binary io)))
   (sagittarius))
  (import (snow bytevector))
  (begin

    (cond-expand

     ((or srfi-91
          gambit)

      (define binio-read-subu8vector read-subu8vector)
      (define binio-write-subu8vector write-subu8vector))

     (else

      (define (binio-read-subu8vector u8vect start end . args)
        (let* ((args-len (length args))
               (port (if (> args-len 0)
                         (list-ref args 0)
                         (current-input-port))))
          (let loop ((i start))
            (if (< i end)
                (let ((n (read-u8 port)))
                  (if (eof-object? n)
                      (- i start)
                      (begin
                        (bytevector-u8-set! u8vect i n)
                        (loop (+ i 1)))))
                (- i start)))))

      (define (binio-write-subu8vector u8vect start end . args)
        (let* ((args-len (length args))
               (port (if (> args-len 0)
                         (list-ref args 0)
                         (current-output-port))))
          (let loop ((i start))
            (if (< i end)
                (begin
                  (write-u8 (bytevector-u8-ref u8vect i) port)
                  (loop (+ i 1)))
                (- i start)))))))

    (cond-expand

     (bigloo

      (define (binio-open-input-file filename)
        (let ((p (open-input-file filename)))
          (if (input-port? p)
              p
              (raise (instantiate::&io-port-error
                      (proc 'binio-open-input-file)
                      (msg "Cannot open file for input")
                      (obj filename))))))

      (define (binio-open-output-file filename)
        (let ((p (open-output-file filename)))
          (if (output-port? p)
              p
              (raise (instantiate::&io-port-error
                      (proc 'binio-open-input-file)
                      (msg "Cannot open file for output")
                      (obj filename)))))))

     (kawa

      (define (binio-open-input-file filename)
        (fluid-let ((port-char-encoding #f))
          (open-input-file filename)))

      (define (binio-open-output-file filename)
        (fluid-let ((port-char-encoding #f))
          (open-output-file filename))))

     (sisc

      (define (binio-open-input-file filename)
        (open-input-file filename "8859_1"))

      (define (binio-open-output-file filename)
        (open-output-file filename "8859_1")))

     (sagittarius

      (define (binio-open-input-file filename)
        (open-binary-input-file filename))

      (define (binio-open-output-file filename)
        (if (file-exists? filename) (delete-file filename))
        (open-binary-output-file filename)))

     (else

      (define (binio-open-input-file filename)
        (open-binary-input-file filename))

      (define (binio-open-output-file filename)
        (open-binary-output-file filename))))


    (define (write-latin-1-string str bin-port)
      (let ((bv (string->latin-1 str)))
        (binio-write-subu8vector
         bv 0 (bytevector-length bv) bin-port)))


    (define (read-latin-1-char in)
      (let ((i (read-u8 in)))
        (cond ((eof-object? i) i)
              (else (integer->char i)))))

    (define (peek-latin-1-char in)
      (let ((i (peek-u8 in)))
        (cond ((eof-object? i) i)
              (else (integer->char i)))))

    ;; These are adapted from chibi's io.scm.
    (define (%read-line n in)
      (let ((out (open-output-string)))
        (let lp ((i 0))
          (let ((ch (peek-latin-1-char in)))
            (cond
             ((eof-object? ch)
              (let ((res (get-output-string out)))
                (and (not (equal? res "")) res)))
             ((eqv? ch #\newline)
              (read-latin-1-char in)
              (get-output-string out))
             ((eqv? ch #\return)
              (read-latin-1-char in)
              (if (eqv? #\newline (peek-latin-1-char in))
                  (read-latin-1-char in))
              (get-output-string out))
             ((and n (>= i n))
              (get-output-string out))
             (else
              (write-char (read-latin-1-char in) out)
              (lp (+ i 1))))))))

    (define (read-latin-1-line . o)
      (let* ((in (if (pair? o) (car o) (current-input-port)))
             (n (if (and (pair? o) (pair? (cdr o))) (car (cdr o)) #f)))
        (let ((res (%read-line n in)))
          (if (not res)
              (eof-object)
              (let ((len (string-length res)))
                (cond
                 ((and (> len 0) (eqv? #\newline (string-ref res (- len 1))))
                  (if (and (> len 1)
                           (eqv? #\return (string-ref res (- len 2))))
                      (substring res 0 (- len 2))
                      (substring res 0 (- len 1))))
                 ((and (> len 0) (eqv? #\return (string-ref res (- len 1))))
                  (substring res 0 (- len 1)))
                 (else
                  res)))))))

    ))
