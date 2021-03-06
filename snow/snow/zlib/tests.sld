(define-library (snow zlib tests)
  (export run-tests)
  (import (scheme base)
          (scheme file)
          (snow binio)
          (snow genport)
          (snow zlib))
  (begin
    (define (run-tests)
      (let* (;; (p (genport-open-input-file "test.gz"))
             (bin-port
              (if (file-exists? "test.gz")
                  (binio-open-input-file "test.gz")
                  (binio-open-input-file "snow/zlib/test.gz")))
             (zipped-p (genport-native-input-port->genport bin-port))
             (unzipped-p (gunzip-genport zipped-p))
             (unzipped-data (utf8->string (genport-read-u8vector unzipped-p)))
             (data (string-append
                    "Twas brillig, and the slithy toves\n"
                    "Did gyre and gimble in the wabe:\n"
                    "All mimsy were the borogoves,\n"
                    "And the mome raths outgrabe.\n")))
        (genport-close-input-port unzipped-p)
        (equal? unzipped-data data)))))
