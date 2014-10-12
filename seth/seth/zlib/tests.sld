(define-library (seth zlib tests)
  (export run-tests)
  (import (scheme base)
          (scheme file)
          (seth port-extras)
          (snow genport)
          (seth zlib))
  (begin
    (define (run-tests)
      (and

       (let* ((p (open-binary-input-file "data.deflate"))
              (p-inf (input-port->inflating-port p))
              (data (read-all-u8 p-inf))
              (orig-p (open-binary-input-file "data.plaintext"))
              (orig-data (read-all-u8 orig-p)))
         (equal? data orig-data))

       (let* ((p-plain (open-binary-input-file "data.plaintext"))
              (data-plain (read-all-u8 p-plain))
              (p-plain (open-input-bytevector data-plain))
              (p-def (input-port->deflating-port p-plain))
              (data-def (read-all-u8 p-def))
              (p-orig (open-input-bytevector data-def))
              (p-inf (input-port->inflating-port p-orig))
              (data-orig (read-all-u8 p-inf)))
         (equal? data-plain data-orig))

       ))))
