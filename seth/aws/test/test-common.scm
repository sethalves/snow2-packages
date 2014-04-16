(define (main-program)

  (log-http-to-stderr #f)

  (let ((credentials (read-credentials "credentials")))

;    (write (get-object credentials "gloebit-deb-repo"
;                       "repo/oauth2client/index.html"))
;    (newline)


    (and
     (bucket-exists? credentials "snow2")
     (not (bucket-exists? credentials "i-dont-exist"))
     (member "snow2" (list-buckets credentials))
     (member "aws.tgz" (list-objects credentials "snow2"))
     (let ((data (get-object credentials "snow2" "index.scm")))
       (cond ((not data) #f)
             (else
              (let ((str (utf8->string data)))
                (string-prefix? "(repository\n" str)))))

     #t)))
