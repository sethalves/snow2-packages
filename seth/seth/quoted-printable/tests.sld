(define-library (seth quoted-printable tests)
  (export run-tests)
  (import (scheme base)
          (seth quoted-printable))
  (begin
    (define (run-tests)
      (and
       (equal?
        (quoted-printable-decode-string
         (string-append
          "If you believe that truth=3Dbeauty, then surely =\n"
          "mathematics is the most beautiful branch of philosophy."))
        "If you believe that truth=beauty, then surely mathematics is the most beautiful branch of philosophy.")

       (equal? (quoted-printable-encode-string "abc") "abc")

       #t))))
