(define (main-program)

;  (display (snow-directory-subfiles "." '(directory)))
;  (newline)

  (and
   (member "Makefile" (snow-directory-files "."))
   (not (member ".." (snow-directory-files ".")))

   (snow-file-exists? "Makefile")
   (not (snow-file-exists? "not-a-file"))

   (snow-file-directory? "snow")
   (not (snow-file-directory? "Makefile"))

   (let ((hndl (open-output-file "rename-me")))
     (display "something\n" hndl)
     (close-output-port hndl)
     (snow-rename-file "rename-me" "delete-me")
     (and
      (not (snow-file-exists? "rename-me"))
      (snow-file-exists? "delete-me")))

   (begin
     (snow-delete-file "delete-me")
     (not (snow-file-exists? "delete-me")))

   (begin
     (snow-create-directory "a-directory")
     (snow-file-directory? "a-directory"))

   (begin
     (snow-delete-directory "a-directory")
     (not (snow-file-exists? "a-directory")))

   (begin
     (cond ((snow-file-exists? "symlink-test-file")
            (snow-delete-file "symlink-test-file")))
     (snow-create-symbolic-link "Makefile" "symlink-test-file")
     (let ((r (and (snow-file-symbolic-link? "symlink-test-file")
                   (snow-file-exists? "symlink-test-file")
                   (not (snow-file-symbolic-link? "Makelie")))))
       (snow-delete-file "symlink-test-file")
       r))


   (equal? (snow-filename-extension "something.blah") ".blah")


   (equal? (snow-filename-strip-extension "something.blah") "something")

   (equal? (snow-filename-directory "/tmp/something.blah") "/tmp/")

   (equal? (snow-filename-strip-directory "/tmp/something.blah")
           "something.blah")


   (equal? (snow-filename-strip-trailing-directory-separator "/tmp/") "/tmp")
   (equal? (snow-filename-strip-trailing-directory-separator "/tmp") "/tmp")


   (equal? (snow-make-filename "/tmp" "hi") "/tmp/hi")

   (equal? (snow-directory-subfiles "." '(directory)) '("." "./snow"))

   (snow-filename-relative? "../ok/fuh")
   (not (snow-filename-relative? "/ok/fuh"))

   (equal? (snow-file-size "../Makefile") 46)

   #t))
