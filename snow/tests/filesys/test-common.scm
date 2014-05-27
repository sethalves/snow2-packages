(define (main-program)

  (write (snow-directory-subfiles "." '(directory)))
  (newline)

  (and
   (member "Makefile" (snow-directory-files "."))
   (not (member ".." (snow-directory-files ".")))

   (file-exists? "Makefile")
   (not (file-exists? "not-a-file"))

   (snow-file-directory? "snow")
   (not (snow-file-directory? "Makefile"))

   (let ((hndl (open-output-file "rename-me")))
     (display "something\n" hndl)
     (close-output-port hndl)
     (snow-rename-file "rename-me" "delete-me")
     (and
      (not (file-exists? "rename-me"))
      (file-exists? "delete-me")))

   (begin
     (delete-file "delete-me")
     (not (file-exists? "delete-me")))

   (begin
     (snow-create-directory "a-directory")
     (snow-file-directory? "a-directory"))

   (begin
     (snow-delete-directory "a-directory")
     (not (file-exists? "a-directory")))

   (begin
     (cond ((file-exists? "symlink-test-file")
            (delete-file "symlink-test-file")))
     (snow-create-symbolic-link "Makefile" "symlink-test-file")
     (let ((r (and (snow-file-symbolic-link? "symlink-test-file")
                   (file-exists? "symlink-test-file")
                   (not (snow-file-symbolic-link? "Makelie")))))
       (delete-file "symlink-test-file")
       r))


   (equal? (snow-filename-extension "something.blah") ".blah")


   (equal? (snow-filename-strip-extension "something.blah") "something")

   (equal? (snow-filename-directory "/tmp/something.blah") "/tmp/")

   (equal? (snow-filename-strip-directory "/tmp/something.blah")
           "something.blah")


   (equal? (snow-filename-strip-trailing-directory-separator "/tmp/") "/tmp")
   (equal? (snow-filename-strip-trailing-directory-separator "/tmp") "/tmp")


   (equal? (snow-make-filename "/tmp" "hi") "/tmp/hi")

   (lset= equal?
          (snow-directory-subfiles "." '(directory))
          '("." "./srfi" "./srfi/srfi-1" "./snow"))

   (snow-filename-relative? "../ok/fuh")
   (not (snow-filename-relative? "/ok/fuh"))

   (equal? (snow-file-size "Makefile") 89)

   ;; ;; (begin
   ;; ;;   (write (snow-file-mtime "test-common.scm"))
   ;; ;;   (newline)
   ;; ;;   #t)

   (> (snow-file-mtime "test-common.scm") 1398705085)

   (let ((here (snow-split-filename (current-directory))))
     (change-directory "..")
     (let ((up (snow-split-filename (current-directory))))
       (equal? (cdr (reverse here)) (reverse up))))

   #t))
