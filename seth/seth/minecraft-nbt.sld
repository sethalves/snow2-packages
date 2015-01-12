(define-library (seth minecraft-nbt)
  (export nbt->sexp
          nbt-bytevector->sexp
          nbt-genport->sexp
          nbt-filename->sexp)
  (import (scheme base)
          (scheme write)
          (scheme file)
          (snow genport)
          (snow zlib)
          (snow assert)
          (weinholt struct pack)
          )
  (begin


    (define (nbt-byte->sexp data index)
      (snow-assert (bytevector? data))
      (snow-assert (>= index 0))
      (snow-assert (< index (bytevector-length data)))
      (values `(byte ,(bytevector-u8-ref data index)) (+ index 1)))


    (define (nbt-short->sexp data index)
      (snow-assert (bytevector? data))
      (snow-assert (>= index 0))
      (snow-assert (< index (bytevector-length data)))
      (values `(short ,(unpack "!us" data index)) (+ index 2)))


    (define (nbt-int->sexp data index)
      (snow-assert (bytevector? data))
      (snow-assert (>= index 0))
      (snow-assert (< index (bytevector-length data)))
      (values `(int ,(unpack "!ul" data index)) (+ index 4)))


    (define (nbt-long->sexp data index)
      (snow-assert (bytevector? data))
      (snow-assert (>= index 0))
      (snow-assert (< index (bytevector-length data)))
      (values `(long ,(unpack "!uq" data index)) (+ index 8)))


    (define (nbt-float->sexp data index)
      (snow-assert (bytevector? data))
      (snow-assert (>= index 0))
      (snow-assert (< index (bytevector-length data)))
      (values `(float ,(unpack "!uf" data index)) (+ index 4)))


    (define (nbt-double->sexp data index)
      (snow-assert (bytevector? data))
      (snow-assert (>= index 0))
      (snow-assert (< index (bytevector-length data)))
      (values `(double ,(unpack "!ud" data index)) (+ index 8)))


    (define (nbt-string->sexp data index)
      (snow-assert (bytevector? data))
      (snow-assert (>= index 0))
      (snow-assert (< index (bytevector-length data)))
      (let* ((string-len (bytevector-u8-ref data (+ index 1)))
             (s (utf8->string
                 (bytevector-copy data (+ index 2) (+ index 2 string-len)))))
        (values `(string ,s) (+ index 2 string-len))))


    (define (nbt-compound->sexp data index)
      (snow-assert (bytevector? data))
      (snow-assert (>= index 0))
      (snow-assert (< index (bytevector-length data)))
      (let loop ((index index)
                 (result '()))
        (let-values (((sexp new-index) (nbt->sexp data index)))
          (cond ((eq? sexp 'end)
                 (values `(compound ,(reverse result)) index))
                (else
                 (loop new-index (cons sexp result)))))))



    (define (nbt->sexp data index)
      (snow-assert (bytevector? data))
      (snow-assert (>= index 0))
      (snow-assert (< index (bytevector-length data)))
      (let ((tag-type (bytevector-u8-ref data index)))
        (if (= tag-type 0) (values 'end (+ index 1))
            (let* ((name-len0 (bytevector-u8-ref data (+ index 1)))
                   (name-len1 (bytevector-u8-ref data (+ index 2)))
                   (name-len (+ (* name-len0 256) name-len1))
                   (data-start (+ index name-len 3))
                   (name
                    (utf8->string
                     (bytevector-copy data (+ index 3) data-start))))
              (let-values
                  (((sexp new-index)
                    (case tag-type
                      ((0) (values 'end (+ index 1)))
                      ((1) (nbt-byte->sexp data data-start))
                      ((2) (nbt-short->sexp data data-start))
                      ((3) (nbt-int->sexp data data-start))
                      ((4) (nbt-long->sexp data data-start))
                      ((5) (nbt-float->sexp data data-start))
                      ((6) (nbt-double->sexp data data-start))
                      ((8) (nbt-string->sexp data data-start))
                      ((10) (nbt-compound->sexp data data-start))
                      (else
                       (error "unexpected nbt tag type" tag-type)))))
                (values
                 (cons name sexp) new-index))))))



    ;; nbt-data should be gunzipped already
    (define (nbt-bytevector->sexp nbt-data)
      (let loop ((index 0)
                 (result '()))
        (let-values (((sexp new-index) (nbt->sexp nbt-data index)))
          (if (< new-index (bytevector-length nbt-data))
              (loop new-index (cons sexp result))
              (reverse result)))))


    (define (nbt-genport->sexp zipped-p)
      (let* ((unzipped-p (gunzip-genport zipped-p))
             (nbt-data (genport-read-u8vector unzipped-p)))
        (nbt-bytevector->sexp nbt-data)))


    (define (nbt-filename->sexp input-filename)
      (let* ((zipped-p (genport-open-input-file input-filename))
             (result (nbt-genport->sexp zipped-p)))
        (genport-close-input-port zipped-p)
        result))

    ))
