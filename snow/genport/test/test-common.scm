(define (main-program)
  (and
   (let* ((p (open-input-bytevector (string->utf8 "abcdefghijklmnop")))
          (gp (genport-native-input-port->genport p))
          (dgp (genport->delimted-genport gp 5))
          )
     (and
      (equal? (genport-read-u8vector dgp) (bytevector 97 98 99 100 101))
      (equal? (genport-read-u8vector gp)
              (bytevector 102 103 104 105 106 107 108 109 110 111 112))))


   (let* ((p (open-input-bytevector (string->utf8 "abcdefghijklmnop")))
          (gp (genport-native-input-port->genport p))
          (gpp (genport->binary-input-port gp))
          )
     (and (equal? (utf8->string (read-bytevector 16 gpp))
                  "abcdefghijklmnop")
          (eof-object? (read-bytevector 16 gpp))))


   ))
