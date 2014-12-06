(define-library (snow filesys tests)
  (export run-tests)
  (import (scheme base)
          (scheme write)
          (scheme file)
          (srfi 1)
          (snow filesys))
  (begin
    (define (run-tests)
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


       (if (file-exists? "tests.sld")
           (lset= equal?
                  (snow-directory-subfiles "." '(directory))
                  '("."
                    "./chibi"
                    "./snow"
                    "./snow/filesys"
                    "./srfi"
                    "./srfi/srfi-1"
                    "./srfi-tests"
                    "./srfi-tests/1"
                    "./srfi-tests/13"
                    "./srfi-tests/14"
                    "./srfi-tests/60"))
           (lset= equal?
                  (snow-directory-subfiles "snow/extio" '(directory))
                  '("snow/extio"
                    "snow/extio/chibi"
                    "snow/extio/srfi"
                    "snow/extio/srfi/srfi-1"
                    "snow/extio/snow"
                    "snow/extio/snow/extio"
                    "snow/extio/snow/bytevector"
                    "snow/extio/srfi-tests"
                    "snow/extio/srfi-tests/13"
                    "snow/extio/srfi-tests/60"
                    "snow/extio/srfi-tests/1"
                    "snow/extio/srfi-tests/14")))


       (snow-filename-relative? "../ok/fuh")
       (not (snow-filename-relative? "/ok/fuh"))

       (begin
         (let ((h (open-output-file "/tmp/extio-test-file")))
           (display "aaaaaaaaaaaaaaaaaaaa" h)
           (close-output-port h)
           (let ((result (= (snow-file-size "/tmp/extio-test-file") 20)))
             (delete-file "/tmp/extio-test-file"))))



       ;; (begin
       ;;   (write (snow-file-mtime "test-common.scm"))
       ;;   (newline)
       ;;   #t)

       (if (file-exists? "tests.sld")
           (> (snow-file-mtime "tests.sld") 1398705085)
           (> (snow-file-mtime "snow/filesys/tests.sld") 1398705085))

       (let ((here (snow-split-filename (current-directory))))
         (change-directory "..")
         (let ((up (snow-split-filename (current-directory))))
           (equal? (cdr (reverse here)) (reverse up))))


       #t))))
