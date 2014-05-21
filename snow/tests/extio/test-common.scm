(define (main-program)
  (snow-force-output)
  (snow-force-output (current-output-port))
  (snow-pretty-print '(1 2 3))
  (snow-pretty-print '(1 2 3) (current-output-port))

  (and
   (let* ((test-str "DURING the whole of a dull, dark, and soundless day in the autumn of the year, when the clouds hung oppressively low in the heavens, I had been passing alone, on horseback, through a singularly dreary tract of country; and at length found myself, as the shades of the evening drew on, within view of the melancholy House of Usher. I know not how it was--but, with the first glimpse of the building, a sense of insufferable gloom pervaded my spirit. I say insufferable; for the feeling was unrelieved by any of that half-pleasurable, because poetic, sentiment, with which the mind usually receives even the sternest natural images of the desolate or terrible.")
          (orig-port (open-input-string test-str))
          (d-port (make-delimited-input-port orig-port 100))
          (r-str-0 (read-string 300 d-port))
          (r-str-1 (read-string 300 d-port))
          ;; (r-str-1 (read-char d-port))
          (cont-str (read-string 5 orig-port))
          )
     ;; (write r-str-0)
     ;; (newline)
     ;; (write r-str-1)
     ;; (newline)
     ;; (write cont-str)
     ;; (newline)
     (and
      (equal? (substring test-str 0 100) r-str-0)
      (eof-object? r-str-1)
      (equal? cont-str "oppre")))

   (let* ((p (open-input-bytevector (bytevector 10 11 12 13 14 15)))
          (p-del (make-delimited-input-port p 3)))
     (and
      (= (read-u8 p-del) 10)
      (= (read-u8 p-del) 11)
      (= (read-u8 p-del) 12)
      (eof-object? (read-u8 p-del))))

   (let* ((data-str (string-append
                     "blah blah blah"
                     (string (integer->char #x40a)
                             (integer->char #x40b)
                             (integer->char #x40c))
                     (string (integer->char #x1F700)
                             (integer->char #x1F701)
                             (integer->char #x1F702))))
          (data-bv (string->utf8 data-str))
          (p-bin (open-input-bytevector data-bv))
          (p-txt (binary-port->textual-port p-bin))
          (new-str (read-string 20 p-txt)))

     ;; (display "data-str=")
     ;; (write data-str)
     ;; (newline)
     ;; (display " new-str=")
     ;; (write new-str)
     ;; (newline)

     (equal? data-str new-str))

;   ))



   (let* ((data-str (string-append
                     "The report gives a defining description of the "
                     "programming language Scheme. Scheme is a "
                     "statically scoped and properly tail recursive "
                     "dialect of the Lisp programming language [23] "
                     "invented by Guy Lewis Steele Jr. and Gerald Jay "
                     "Sussman. It was designed to have exceptionally "
                     "clear and simple semantics and few different ways "
                     "to form expressions. A wide variety of programming "
                     "paradigms, including imperative, functional, and "
                     "object-oriented styles, find convenient expression "
                     "in Scheme.  The introduction offers a brief "
                     "history of the language and of the report.  The "
                     "first three chapters present the fundamental ideas "
                     "of the language and describe the notational "
                     "conventions used for describing the language and "
                     "for writing programs in the language."
                     (string (integer->char #x40a)
                             (integer->char #x40b)
                             (integer->char #x40c))
                     (string (integer->char #x1F700)
                             (integer->char #x1F701)
                             (integer->char #x1F702))
                     ))
          (p-txt (open-input-string data-str))
          (p-bin (textual-port->binary-port p-txt))
          (data-bv (read-bytevector 767 p-bin))
          ;; (data-str-from-bv (utf8->string data-bv))
          (data-str-bv (string->utf8 data-str))
          )
     ;; (equal? data-str data-str-from-bv)
     ;; (write data-bv) (newline) (newline)
     ;; (write data-str-bv) (newline)

     (equal? data-bv data-str-bv)
     )


   (let* ((p (open-binary-input-file "Makefile"))
          (t0 (snow-port-position p)))
     (read-u8 p)
     (let ((t1 (snow-port-position p)))
       (read-u8 p)
       (let ((t2 (snow-port-position p)))
         (close-input-port p)
         (and (= t0 0)
              (= t1 1)
              (= t2 2)))))


   (let* ((p (open-binary-input-file "Makefile"))
          (t0 (snow-port-position p)))
     (snow-set-port-position! p 15)
     (let ((t1 (snow-port-position p)))
       (read-u8 p)
       (snow-set-port-position! p 5)
       (let ((t2 (snow-port-position p)))
         (snow-set-port-position! p 0)
         (let ((t3 (snow-port-position p)))
           (close-input-port p)
           ;; (display (list t0 t1 t2 t3)) (newline)
           (and (= t0 0)
                (= t1 15)
                (= t2 5)
                (= t3 0)
                )))))


   (let* ((p (open-binary-input-file "Makefile"))
          (t0 (snow-port-position p)))
     (snow-set-port-position-from-current! p 15)
     (let ((t1 (snow-port-position p)))
       (read-u8 p)
       (snow-set-port-position-from-current! p -5)
       (let ((t2 (snow-port-position p)))
         (snow-set-port-position-from-current! p 10)
         (let ((t3 (snow-port-position p)))
           (close-input-port p)
           ;; (display (list t0 t1 t2 t3)) (newline)
           (and (= t0 0)
                (= t1 15)
                (= t2 11)
                (= t3 21)
                )))))


   (let* ((p (open-binary-input-file "Makefile"))
          (t0 (snow-port-position p)))
     (snow-set-port-position-from-end! p 15)
     (let ((t1 (snow-port-position p)))
       (read-u8 p)
       (snow-set-port-position-from-end! p -5)
       (let ((t2 (snow-port-position p)))
         (snow-set-port-position-from-end! p 10)
         (let ((t3 (snow-port-position p)))
           (close-input-port p)
           ;; (display (list t0 t1 t2 t3)) (newline)
           (and (= t0 0)
                (= t1 81)
                (= t2 91)
                (= t3 86)
                )))))

   #t))
