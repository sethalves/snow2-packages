(define-library (seth aws common)
  (export read-credentials
          make-credentials
          credentials?
          credentials-access-key-id
          credentials-secret-access-key
          )

  (import (scheme base)
          (scheme read)
          (scheme file)
          )

  (begin

    (define-record-type <credentials>
      (make-credentials access-key-id secret-access-key)
      credentials?
      (access-key-id credentials-access-key-id)
      (secret-access-key credentials-secret-access-key))

    (define (read-credentials filename)
      ;; XXX make a better parser
      (let* ((creds-hndl (open-input-file filename))
             (creds-line0 (read-line creds-hndl))
             (creds-line1 (read-line creds-hndl)))
        (close-input-port creds-hndl)
        (make-credentials
         (substring creds-line0 15 (string-length creds-line0))
         (substring creds-line1 13 (string-length creds-line1)))))


    ))
