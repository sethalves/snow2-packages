(define (main-program)

  (and
   (equal?
    (quoted-printable-decode-string
     (string-append
      "If you believe that truth=3Dbeauty, then surely =\n"
      "mathematics is the most beautiful branch of philosophy."))
    "If you believe that truth=beauty, then surely mathematics is the most beautiful branch of philosophy.")

   (equal? (quoted-printable-encode-string "abc") "abc")

   #t)

  )
