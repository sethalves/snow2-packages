(define-library (seth binary-pack tests)
  (export run-tests)
  (import (scheme base)
          (snow bytevector)
          (seth binary-pack)
          (prefix (seth binary-pack) binary-))
  (begin
    (define (run-tests)
      (binary-pack-u32 (make-bytevector 8) 0 4444 #f))))
