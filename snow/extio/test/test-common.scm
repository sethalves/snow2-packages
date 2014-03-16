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
     (write r-str-0)
     (newline)
     (write r-str-1)
     (newline)
     (write cont-str)
     (newline)
     (and
      (equal? (substring test-str 0 100) r-str-0)
      (eof-object? r-str-1)
      (equal? cont-str "oppre")))


   (let* ((p (open-input-bytevector (bytevector 0 1 150 3 4 5 6)))
          (p-textual (binary-port->latin-1-textual-port p)))

     (write (char->integer (read-char p-textual))) (newline)
     (write (char->integer (read-char p-textual))) (newline)
     (write (char->integer (read-char p-textual))) (newline)
     (write (char->integer (read-char p-textual))) (newline)
     (write (char->integer (read-char p-textual))) (newline)
     (write (char->integer (read-char p-textual))) (newline)
     (write (char->integer (read-char p-textual))) (newline)
     #t

     ;; (and
     ;;  (= (char->integer (read-char p-textual)) 0)
     ;;  (= (char->integer (read-char p-textual)) 1)
     ;;  (= (char->integer (read-char p-textual)) 2)
     ;;  (= (char->integer (read-char p-textual)) 3)
     ;;  (= (char->integer (read-char p-textual)) 127)
     ;;  (= (char->integer (read-char p-textual)) 128))
     )

   (let* ((p (open-input-bytevector (bytevector 10 11 12 13 14 15)))
          (p-del (make-delimited-input-port p 3)))
     (and
      (= (read-u8 p-del) 10)
      (= (read-u8 p-del) 11)
      (= (read-u8 p-del) 12)
      (eof-object? (read-u8 p-del))))


   ))
