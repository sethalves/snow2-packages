(define-library (snow filesys tests)
  (export run-tests)
  (import (scheme base)
          (scheme write)
          (scheme file)
          (srfi 1)
          (snow filesys)
          (srfi 78))
  (begin
    (define (run-tests)

      (check-reset!)

      (check (member "Makefile" (snow-directory-files ".")) => #t)
      (check (member ".." (snow-directory-files ".")) => #f)

      (check (file-exists? "Makefile") => #t)
      (check (file-exists? "not-a-file") => #f)

      (check (snow-file-directory? "snow") => #t)
      (check (snow-file-directory? "Makefile") => #f)

      (let ((hndl (open-output-file "rename-me")))
        (display "something\n" hndl)
        (close-output-port hndl)
        (snow-rename-file "rename-me" "delete-me")
        (check (file-exists? "rename-me") => #f)
        (check (file-exists? "delete-me") => #t))

      (delete-file "delete-me")
      (check (file-exists? "delete-me") => #f)

      (snow-create-directory "a-directory")
      (check (snow-file-directory? "a-directory") => #t)

      (snow-delete-directory "a-directory")
      (check (file-exists? "a-directory") => #f)

      (cond ((file-exists? "symlink-test-file")
             (delete-file "symlink-test-file")))
      (snow-create-symbolic-link "Makefile" "symlink-test-file")
      (check (snow-file-symbolic-link? "symlink-test-file") => #t)
      (check (file-exists? "symlink-test-file") => #t)
      (check (snow-file-symbolic-link? "Makelie") => #f)
      (delete-file "symlink-test-file")


      (check (equal? (snow-filename-extension "something.blah") ".blah") => #t)

      (check (equal? (snow-filename-strip-extension "something.blah")
                     "something") => #t)

      (check (equal? (snow-filename-directory "/tmp/something.blah")
                     "/tmp/") => #t)

      (check (equal? (snow-filename-strip-directory "/tmp/something.blah")
                     "something.blah") => #t)


      (check (equal? (snow-filename-strip-trailing-directory-separator
                      "/tmp/") "/tmp") => #t)
      (check (equal? (snow-filename-strip-trailing-directory-separator
                      "/tmp") "/tmp") => #t)


      (check (equal? (snow-make-filename "/tmp" "hi") "/tmp/hi") => #t)

      (check
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
       => #t)


      (check (snow-filename-relative? "../ok/fuh") => #t)
      (check (snow-filename-relative? "/ok/fuh") => #f)

      (let ((h (open-output-file "/tmp/extio-test-file")))
        (display "aaaaaaaaaaaaaaaaaaaa" h)
        (close-output-port h)
        (check (snow-file-size "/tmp/extio-test-file") => 20)
        (delete-file "/tmp/extio-test-file"))


      ;; (begin
      ;;   (write (snow-file-mtime "test-common.scm"))
      ;;   (newline)
      ;;   #t)

      (check
       (if (file-exists? "tests.sld")
           (> (snow-file-mtime "tests.sld") 1398705085)
           (> (snow-file-mtime "snow/filesys/tests.sld") 1398705085))
       => #t)

      (let* ((save-cwd (current-directory))
             (here (snow-split-filename save-cwd)))
        (change-directory "..")
        (let ((up (snow-split-filename (current-directory))))
          (check (equal? (cdr (reverse here)) (reverse up)) => #t))
        (change-directory save-cwd))

      (check-passed? 28))))
