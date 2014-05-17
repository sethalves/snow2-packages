
(define (main-program)
  (and

   (let ((bv (bytevector 1 2 3 4)))
     (display bv)
     (newline)
     bv)

   (equal?
    (reverse-bytevector-list->latin-1-string
     (list (string->latin-1 "def")
           (string->latin-1 "abc")))
    "abcdef")


   (equal?
    (reverse-bytevector-list->latin-1-string
     (list (string->latin-1 "")
           (string->latin-1 "abc")))
    "abc")


   (equal?
    (reverse-bytevector-list->latin-1-string
     (list (string->latin-1 "abc")
           (string->latin-1 "")))
    "abc")

   (equal?
    (reverse-bytevector-list->latin-1-string
     (list (string->latin-1 "")
           (string->latin-1 "")))
    "")

   (equal?
    (reverse-bytevector-list->latin-1-string
     (list))
    "")

   (equal?
    (reverse-bytevector-list->bytevector
     (list (bytevector 4 5 6)
           (bytevector 1 2 3)))
    (bytevector 1 2 3 4 5 6))


   (equal? (hex-string->bytes "a745ff12")
           (bytevector #xa7 #x45 #xff #x12))

   (equal? (hex-string->bytes "")
           (bytevector))

   (begin
     (display (bytes->hex-string (bytevector #xa7 #x45 #xff #x12)))
     (newline)
     (equal? (bytes->hex-string (bytevector #xa7 #x45 #xff #x12))
             "a745ff12"))

   (equal? (bytes->hex-string (bytevector)) "")

   #t

   ))
