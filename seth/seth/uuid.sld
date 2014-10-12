
(define-library (seth uuid)
  (export uuid:unpack uuid:pack uuid:random uuid:null uuid:rx)
  (import (scheme base))
  (cond-expand
   (sagittarius (import (rnrs)))
   (else))
  (import (srfi 60)
          (seth binary-pack)
          (srfi 13)
          (srfi 27))
  (begin

    ;; (cond-expand
    ;;  (sagittarius (define arithmetic-shift bitwise-arithmetic-shift))
    ;;  (else))


    (define (uuid:unpack bv idx uuid-cb)
      (define (int-to-hex-str int result-length)
        (let ((n (if (integer? int)
                     (number->string int 16)
                     (number->string int))))

          (string-pad n result-length #\0)))
      (let* ((u32-0 0) (u32-1 0) (u32-2 0) (u32-3 0)
             (idx (unpack-u32 bv idx (lambda (x) (set! u32-0 x))))
             (idx (unpack-u32 bv idx (lambda (x) (set! u32-1 x))))
             (idx (unpack-u32 bv idx (lambda (x) (set! u32-2 x))))
             (idx (unpack-u32 bv idx (lambda (x) (set! u32-3 x))))
             (part0 u32-0)
             (part1 (arithmetic-shift (bitwise-and u32-1 #xffff0000) -16))
             (part2 (bitwise-and u32-1 #xffff))
             (part3 (arithmetic-shift (bitwise-and u32-2 #xffff0000) -16))
             (part4 (+ (arithmetic-shift (bitwise-and u32-2 #xffff) 32)
                       u32-3)))
        (uuid-cb
         (string-append (int-to-hex-str part0 8) "-"
                        (int-to-hex-str part1 4) "-"
                        (int-to-hex-str part2 4) "-"
                        (int-to-hex-str part3 4) "-"
                        (int-to-hex-str part4 12)))
        idx))



    (define (uuid:pack bv idx uuid dry-run)
      ;; 00000000-0000-0000-0000-000000000000
      (let* (;; (parts (string-split uuid #\-))
             (parts (string-tokenize uuid (lambda (c) (not (eqv? c #\-)))))
             (part0 (string->number (list-ref parts 0) 16))
             (part1 (string->number (list-ref parts 1) 16))
             (part2 (string->number (list-ref parts 2) 16))
             (part3 (string->number (list-ref parts 3) 16))
             (part4 (string->number (list-ref parts 4) 16))
             ;;
             (u32-0 part0)
             (u32-1 (+ (arithmetic-shift part1 16) part2))
             (u32-2 (+ (arithmetic-shift part3 16)
                       (arithmetic-shift (bitwise-and part4 #xffff00000000) -32)))
             (u32-3 (bitwise-and part4 #xffffffff))
             )
        (let* ((idx (pack-u32 bv idx u32-0 dry-run))
               (idx (pack-u32 bv idx u32-1 dry-run))
               (idx (pack-u32 bv idx u32-2 dry-run))
               (idx (pack-u32 bv idx u32-3 dry-run)))
          idx)))


    (define (uuid:random)
      (let ((bv (make-bytevector 16)))
        (let loop ((i 0))
          (if (= i 16)
              (let* ((uuid #f)
                     (idx (uuid:unpack bv 0 (lambda (u) (set! uuid u)))))
                uuid)
              (begin
                (bytevector-u8-set! bv i (random-integer 256))
                (loop (+ i 1)))))))

    (define uuid:null "00000000-0000-0000-0000-000000000000")

    ;; racket's regular-expressions don't allow the {8} thing.
    ;; (define uuid:rx "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}")
    (define uuid:rx
      (let ((x "[0-9a-fA-F]"))
        (string-append x x x x x x x x "-" x x x x "-" x x x x "-" x x x x "-"
                       x x x x x x x x x x x x)))

    ;; (cond-expand (chicken (register-feature! 'seth.uuid)) (else))
    ))
