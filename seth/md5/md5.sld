(define-library (seth md5)
  (export md5)
  (import (scheme base)
          (snow bytevector)
          (snow srfi-60-integers-as-bits)
          )
  (cond-expand
   (chibi (import (scheme inexact)))
   (chicken
    (import (md5)
            (message-digest)
            ))
   (gauche (import (scheme inexact)))
   (sagittarius (import (scheme inexact)))
   )
  (begin
    (cond-expand

     (chicken

      (define (md5 in-bv)
        (hex-string->bytes
         (message-digest-string (md5-primitive) (utf8->string in-bv)))))

     (else

      (define (byte-extract n byte-num)
        (case byte-num
          ((0) (arithmetic-shift (bitwise-and n #xff000000) -24))
          ((1) (arithmetic-shift (bitwise-and n #xff0000) -16))
          ((2) (arithmetic-shift (bitwise-and n #xff00) -8))
          ((3) (bitwise-and n #xff))))

      ;; initialize T
      (define T
        (let ((T (make-vector 65)))
          (let loop ((i 1))
            (if (= i 65) #t
                (let ((v (exact (floor (* 4294967296 (abs (sin i)))))))
                  (vector-set! T i v)
                  (loop (+ i 1)))))
          T))


      (define (md5:hash-blocks M)
        (define (F x y z)
          ;; F(X,Y,Z) = XY v not(X) Z
          (bitwise-ior (bitwise-and x y) (bitwise-and (bitwise-not x) z)))

        (define (G x y z)
          ;; G(X,Y,Z) = XZ v Y not(Z)
          (bitwise-ior (bitwise-and x z) (bitwise-and y (bitwise-not z))))

        (define (H x y z)
          ;; H(X,Y,Z) = X xor Y xor Z
          (bitwise-xor x (bitwise-xor y z)))

        (define (I x y z)
          ;; I(X,Y,Z) = Y xor (X v not(Z))
          (bitwise-xor y (bitwise-ior x (bitwise-and (bitwise-not z)
                                                     #xffffffff))))

        ;; Before processing any blocks, initialize A, B, C, D
        (let ((A #x67452301)
              (B #xefcdab89)
              (C #x98badcfe)
              (D #x10325476))

          (define (+w . vals)
            (bitwise-and (apply + vals) #xffffffff))

          (define (left-rotate v n)
            (bitwise-ior
             (bitwise-and (arithmetic-shift v n) #xffffffff)
             (arithmetic-shift v (- (- 32 n)))))

          (define (md5-block X)
            (let ((AA A) (BB B) (CC C) (DD D))
              (define (abcd k s i f)
                (set! A (+w B (left-rotate (+w A (f B C D)
                                               (vector-ref X k)
                                               (vector-ref T i)) s))))
              (define (dabc k s i f)
                (set! D (+w A (left-rotate (+w D (f A B C)
                                               (vector-ref X k)
                                               (vector-ref T i)) s))))
              (define (cdab k s i f)
                (set! C (+w D (left-rotate (+w C (f D A B)
                                               (vector-ref X k)
                                               (vector-ref T i)) s))))
              (define (bcda k s i f)
                (set! B (+w C (left-rotate (+w B (f C D A)
                                               (vector-ref X k)
                                               (vector-ref T i)) s))))

              ;; round 1
              (abcd  0  7  1 F) (dabc  1 12  2 F) (cdab  2 17  3 F)
              (bcda  3 22  4 F) (abcd  4  7  5 F) (dabc  5 12  6 F)
              (cdab  6 17  7 F) (bcda  7 22  8 F) (abcd  8  7  9 F)
              (dabc  9 12 10 F) (cdab 10 17 11 F) (bcda 11 22 12 F)
              (abcd 12  7 13 F) (dabc 13 12 14 F) (cdab 14 17 15 F)
              (bcda 15 22 16 F)
              ;; round 2
              (abcd  1  5 17 G) (dabc  6  9 18 G) (cdab 11 14 19 G)
              (bcda  0 20 20 G) (abcd  5  5 21 G) (dabc 10  9 22 G)
              (cdab 15 14 23 G) (bcda  4 20 24 G) (abcd  9  5 25 G)
              (dabc 14  9 26 G) (cdab  3 14 27 G) (bcda  8 20 28 G)
              (abcd 13  5 29 G) (dabc  2  9 30 G) (cdab  7 14 31 G)
              (bcda 12 20 32 G)
              ;; round 3
              (abcd  5  4 33 H) (dabc  8 11 34 H) (cdab 11 16 35 H)
              (bcda 14 23 36 H) (abcd  1  4 37 H) (dabc  4 11 38 H)
              (cdab  7 16 39 H) (bcda 10 23 40 H) (abcd 13  4 41 H)
              (dabc  0 11 42 H) (cdab  3 16 43 H) (bcda  6 23 44 H)
              (abcd  9  4 45 H) (dabc 12 11 46 H) (cdab 15 16 47 H)
              (bcda  2 23 48 H)
              ;; round 4
              (abcd  0  6 49 I) (dabc  7 10 50 I) (cdab 14 15 51 I)
              (bcda  5 21 52 I) (abcd 12  6 53 I) (dabc  3 10 54 I)
              (cdab 10 15 55 I) (bcda  1 21 56 I) (abcd  8  6 57 I)
              (dabc 15 10 58 I) (cdab  6 15 59 I) (bcda 13 21 60 I)
              (abcd  4  6 61 I) (dabc 11 10 62 I) (cdab  2 15 63 I)
              (bcda  9 21 64 I)

              (set! A (+w A AA))
              (set! B (+w B BB))
              (set! C (+w C CC))
              (set! D (+w D DD))))


          (let loop ((i 0))
            (if (= i (vector-length M))
                ;; make output bytevector (in binary form).
                (let ((result (make-bytevector 16)))
                  (bytevector-u8-set! result 0 (byte-extract A 3))
                  (bytevector-u8-set! result 1 (byte-extract A 2))
                  (bytevector-u8-set! result 2 (byte-extract A 1))
                  (bytevector-u8-set! result 3 (byte-extract A 0))

                  (bytevector-u8-set! result 4 (byte-extract B 3))
                  (bytevector-u8-set! result 5 (byte-extract B 2))
                  (bytevector-u8-set! result 6 (byte-extract B 1))
                  (bytevector-u8-set! result 7 (byte-extract B 0))

                  (bytevector-u8-set! result 8 (byte-extract C 3))
                  (bytevector-u8-set! result 9 (byte-extract C 2))
                  (bytevector-u8-set! result 10 (byte-extract C 1))
                  (bytevector-u8-set! result 11 (byte-extract C 0))

                  (bytevector-u8-set! result 12 (byte-extract D 3))
                  (bytevector-u8-set! result 13 (byte-extract D 2))
                  (bytevector-u8-set! result 14 (byte-extract D 1))
                  (bytevector-u8-set! result 15 (byte-extract D 0))

                  result)
                (begin
                  (md5-block (vector-ref M i))
                  (loop (+ i 1)))))))


      (define (md5 in-bv)
        (define (take-4-bytes pos)
          ;; read 4 bytes from in-bv at pos.  the byte just after the end of
          ;; in-bv should be #x80.  any after that should be 0
          (let* ((v-len (bytevector-length in-bv))
                 (take-1-byte (lambda (pos+)
                                (cond ((< pos+ v-len)
                                       (bytevector-u8-ref in-bv pos+))
                                      ((= pos+ v-len) #x80)
                                      (else 0)))))
            (+ (arithmetic-shift (take-1-byte (+ pos 3)) 24)
               (arithmetic-shift (take-1-byte (+ pos 2)) 16)
               (arithmetic-shift (take-1-byte (+ pos 1)) 8)
               (take-1-byte (+ pos 0)))))

        ;; M is the entire input sliced up into blocks.  Each element of M is a
        ;; block.  Each block holds 512 bits of data (meaning, 16 elements, 32
        ;; bits each).
        (let* ((in-length (bytevector-length in-bv)) ;; length of original input
               ;; figure out how many blocks we'll need to hold the message
               ;; and the padding.  "9" because 1 byte to hold the #x80 -- the
               ;; appended 1 bit, and 8 bytes to hold the original size.
               (block-count (exact (ceiling (/ (+ in-length 9) 64))))
               (M (make-vector block-count)))

          ;; fill up M with W vectors
          (let loop ((i 0))
            (if (< i block-count)
                (begin
                  (vector-set! M i (make-vector 16 0))
                  (loop (+ i 1)))
                #t))

          ;; break the M (the input) up into the W vectors
          (let loop ((i 0)
                     (pos 0)
                     (idx 0))
            (cond
             ((> pos in-length) #t) ;; done
             ((= idx 16) (loop (+ i 1) pos 0)) ;; move to next block
             (else ;; copy more input into current block
              (vector-set! (vector-ref M i) idx (take-4-bytes pos))
              (loop i (+ pos 4) (+ idx 1)))))

          ;; overwrite in-bv, so it's not sitting around in ram
          (let loop ((pos 0))
            (if (= pos in-length) #t
                (begin
                  (bytevector-u8-set! in-bv pos 0)
                  (loop (+ pos 1)))))

          ;; store original message length (in bits) in last 8 bytes of the
          ;; last block.
          (let ((last-block (vector-ref M (- block-count 1)))
                (bits (* in-length 8)))
            ;; (vector-set! last-block 15
            ;;              (arithmetic-shift
            ;;               (bitwise-and bits #xffffffff00000000) -32))
            (vector-set! last-block 14 (bitwise-and bits #xffffffff)))

          ;; hash the blocks
          (md5:hash-blocks M)))

      )
     )))
