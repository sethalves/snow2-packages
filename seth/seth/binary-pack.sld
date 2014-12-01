
(define-library (seth binary-pack)
  (export pack-u8 unpack-u8 pack-u16 unpack-u16 unpack-u32 pack-u32
          unpack-str0)

  (import (scheme base))
  (cond-expand
   (chibi
    (import (srfi 33) (snow bytevector) (chibi io)))
   (chicken
    (import (chicken) (snow bytevector) (srfi 4)))
   (sagittarius
    (import (rnrs) (snow bytevector)))
   (else
    (import (srfi 60) (snow bytevector))))

  (begin

    (cond-expand
     (sagittarius (define arithmetic-shift bitwise-arithmetic-shift))
     (else))


    (define (pack-u8 bv idx value dry-run)
      (cond
       ((not dry-run)
        (bytevector-u8-set! bv idx (bitwise-and value #xff))))
      (+ idx 1))


    (define (unpack-u8 bv idx value-cb)
      (value-cb (bytevector-u8-ref bv idx))
      (+ idx 1))


    (define (pack-u16 bv idx value dry-run)
      (cond
       ((not dry-run)
        (bytevector-u8-set! bv idx (arithmetic-shift
                                    (bitwise-and value #xff00) -8))
        (bytevector-u8-set! bv (+ idx 1) (bitwise-and value #xff))))
      (+ idx 2))


    (define (unpack-u16 bv idx value-cb)
      (value-cb
       (bitwise-ior
        (arithmetic-shift (bytevector-u8-ref bv idx) 8)
        (bytevector-u8-ref bv (+ idx 1))))
      (+ idx 2))


    (define (unpack-u32 bv idx value-cb)
      (value-cb
       (bitwise-ior
        (arithmetic-shift (bytevector-u8-ref bv idx) 24)
        (arithmetic-shift (bytevector-u8-ref bv (+ idx 1)) 16)
        (arithmetic-shift (bytevector-u8-ref bv (+ idx 2)) 8)
        (bytevector-u8-ref bv (+ idx 3))))
      (+ idx 4))


    (define (pack-u32 bv idx value dry-run)
      (cond
       ((not dry-run)
        (bytevector-u8-set! bv (+ idx 0)
                            (arithmetic-shift
                             (bitwise-and value #xff000000) -24))
        (bytevector-u8-set! bv (+ idx 1)
                            (arithmetic-shift
                             (bitwise-and value #xff0000) -16))
        (bytevector-u8-set! bv (+ idx 2)
                            (arithmetic-shift
                             (bitwise-and value #xff00) -8))
        (bytevector-u8-set! bv (+ idx 3) (bitwise-and value #xff))))
      (+ idx 4))


    (define (unpack-str0 bv idx value-cb)
      (let loop ((idx idx)
                 (result (list)))
        (let ((c (bytevector-u8-ref bv idx)))
          (cond ((eq? c 0)
                 (value-cb (utf8->string
                            (u8-list->bytevector (reverse result))))
                 (+ idx 1))
                (else
                 (loop (+ idx 1) (cons c result)))))))


    ;; (cond-expand (chicken (register-feature! 'seth.binary-pack)))
    ))
