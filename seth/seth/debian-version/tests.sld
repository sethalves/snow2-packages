(define-library (seth debian-version tests)
  (export run-tests)
  (import (scheme base)
          (scheme write)
          (snow bytevector)
          (srfi 78)
          (seth debian-version))
  (begin


    (define (run-tests)
      (check-reset!)

      (check (debian-version-=?
              (string->debian-version "2.0")
              (make-debian-version "0" "2.0" "0")) => #t)
      (check (debian-version-=?
              (string->debian-version "1:2.0")
              (make-debian-version "1" "2.0" "0")) => #t)
      (check (debian-version-=?
              (string->debian-version "2.0-ok")
              (make-debian-version "0" "2.0" "ok")) => #t)
      (check (debian-version-=?
              (string->debian-version "3:2.0-ok")
              (make-debian-version "3" "2.0" "ok")) => #t)
      (check (debian-version-=?
              (string->debian-version "1~")
              (make-debian-version "0" "1~" "0")) => #t)


      (check (debian-version->string (make-debian-version "0" "2.0" "0"))
             => "2.0")
      (check (debian-version->string (make-debian-version "1" "2.0" "0"))
             => "1:2.0")
      (check (debian-version->string (make-debian-version "0" "2.0" "ok"))
             => "2.0-ok")
      (check (debian-version->string (make-debian-version "3" "2.0" "ok"))
             => "3:2.0-ok")
      (check (debian-version->string (make-debian-version "0" "1~" "0"))
             => "1~")

      (check (debian-version-<? "1" "2") => #t)
      (check (debian-version-<? "2" "1") => #f)
      (check (debian-version-<? "1" "1") => #f)
      (check (debian-version-<? "2.0" "2.1") => #t)
      (check (debian-version-<? "2.1" "2.0") => #f)
      (check (debian-version-<? "1.0" "1.0") => #f)
      (check (debian-version-<? "2:2.0" "2.1") => #f)
      (check (debian-version-<? "2.0" "1:2.1") => #t)
      (check (debian-version-<? "9.5" "110") => #t)
      (check (debian-version-<? "5.3.2" "5.3.1a") => #f)
      (check (debian-version-<? "5.3.2a" "5.3.2b") => #t)
      (check (debian-version-<? "5.3.2a" "5.3.2a") => #f)
      (check (debian-version-<? "5.3.2a-fuh1" "5.3.2a-fuh1") => #f)
      (check (debian-version-<? "5.3.2a-fuh0" "5.3.2a-fuh1") => #t)
      (check (debian-version-<? "1:5.3.2a-fuh0" "5.3.2a-fuh1") => #f)
      (check (debian-version-<? "2.6.18~" "2.6.18") => #t)
      (check (debian-version-<? "2.6.18~" "2.6.18~") => #f)
      (check (debian-version-<? "2.6.18~~" "2.6.18~") => #t)
      (check (debian-version-<? "2.6.18+" "2.6.18~") => #f)
      (check (debian-version-<? "3a" "3b") => #t)
      (check (debian-version-<? "3b" "3a") => #f)
      (check (debian-version-<? "3b" "3b") => #f)
      (check (debian-version-<? "3~" "3b") => #t)
      (check (debian-version-<? "3b" "3~") => #f)
      (check (debian-version-<? "3+" "3b") => #f)
      (check (debian-version-<? "3b" "3+") => #t)

      (check (debian-version->? "2" "1") => #t)
      (check (debian-version->? "1" "2") => #f)
      (check (debian-version->? "1" "1") => #f)
      (check (debian-version->? "2.1" "2.0") => #t)
      (check (debian-version->? "2.0" "2.1") => #f)
      (check (debian-version->? "1.0" "1.0") => #f)
      (check (debian-version->? "2.1" "2:2.0") => #f)
      (check (debian-version->? "1:2.1" "2.0") => #t)
      (check (debian-version->? "110" "9.5") => #t)
      (check (debian-version->? "5.3.1a" "5.3.2") => #f)
      (check (debian-version->? "5.3.2b" "5.3.2a") => #t)
      (check (debian-version->? "5.3.2a" "5.3.2a") => #f)
      (check (debian-version->? "5.3.2a-fuh1" "5.3.2a-fuh1") => #f)
      (check (debian-version->? "5.3.2a-fuh1" "5.3.2a-fuh0") => #t)
      (check (debian-version->? "5.3.2a-fuh1" "1:5.3.2a-fuh0") => #f)
      (check (debian-version->? "2.6.18" "2.6.18~") => #t)
      (check (debian-version->? "2.6.18~" "2.6.18~") => #f)
      (check (debian-version->? "2.6.18~" "2.6.18~~") => #t)
      (check (debian-version->? "2.6.18~" "2.6.18+") => #f)
      (check (debian-version->? "3b" "3a") => #t)
      (check (debian-version->? "3a" "3b") => #f)
      (check (debian-version->? "3b" "3b") => #f)
      (check (debian-version->? "3b" "3~") => #t)
      (check (debian-version->? "3~" "3b") => #f)
      (check (debian-version->? "3b" "3+") => #f)
      (check (debian-version->? "3+" "3b") => #t)

      (check (debian-version-<=? "1" "2") => #t)
      (check (debian-version-<=? "2" "1") => #f)
      (check (debian-version-<=? "1" "1") => #t)
      (check (debian-version-<=? "2.0" "2.1") => #t)
      (check (debian-version-<=? "2.1" "2.0") => #f)
      (check (debian-version-<=? "1.0" "1.0") => #t)
      (check (debian-version-<=? "2:2.0" "2.1") => #f)
      (check (debian-version-<=? "2.0" "1:2.1") => #t)
      (check (debian-version-<=? "9.5" "110") => #t)
      (check (debian-version-<=? "5.3.2" "5.3.1a") => #f)
      (check (debian-version-<=? "5.3.2a" "5.3.2b") => #t)
      (check (debian-version-<=? "5.3.2a" "5.3.2a") => #t)
      (check (debian-version-<=? "5.3.2a-fuh1" "5.3.2a-fuh1") => #t)
      (check (debian-version-<=? "5.3.2a-fuh0" "5.3.2a-fuh1") => #t)
      (check (debian-version-<=? "1:5.3.2a-fuh0" "5.3.2a-fuh1") => #f)
      (check (debian-version-<=? "2.6.18~" "2.6.18") => #t)
      (check (debian-version-<=? "2.6.18~" "2.6.18~") => #t)
      (check (debian-version-<=? "2.6.18~~" "2.6.18~") => #t)
      (check (debian-version-<=? "2.6.18+" "2.6.18~") => #f)
      (check (debian-version-<=? "3a" "3b") => #t)
      (check (debian-version-<=? "3b" "3a") => #f)
      (check (debian-version-<=? "3b" "3b") => #t)
      (check (debian-version-<=? "3~" "3b") => #t)
      (check (debian-version-<=? "3b" "3~") => #f)
      (check (debian-version-<=? "3+" "3b") => #f)
      (check (debian-version-<=? "3b" "3+") => #t)

      (check (debian-version->=? "2" "1") => #t)
      (check (debian-version->=? "1" "2") => #f)
      (check (debian-version->=? "1" "1") => #t)
      (check (debian-version->=? "2.1" "2.0") => #t)
      (check (debian-version->=? "2.0" "2.1") => #f)
      (check (debian-version->=? "1.0" "1.0") => #t)
      (check (debian-version->=? "2.1" "2:2.0") => #f)
      (check (debian-version->=? "1:2.1" "2.0") => #t)
      (check (debian-version->=? "110" "9.5") => #t)
      (check (debian-version->=? "5.3.1a" "5.3.2") => #f)
      (check (debian-version->=? "5.3.2b" "5.3.2a") => #t)
      (check (debian-version->=? "5.3.2a" "5.3.2a") => #t)
      (check (debian-version->=? "5.3.2a-fuh1" "5.3.2a-fuh1") => #t)
      (check (debian-version->=? "5.3.2a-fuh1" "5.3.2a-fuh0") => #t)
      (check (debian-version->=? "5.3.2a-fuh1" "1:5.3.2a-fuh0") => #f)
      (check (debian-version->=? "2.6.18" "2.6.18~") => #t)
      (check (debian-version->=? "2.6.18~" "2.6.18~") => #t)
      (check (debian-version->=? "2.6.18~" "2.6.18~~") => #t)
      (check (debian-version->=? "2.6.18~" "2.6.18+") => #f)
      (check (debian-version->=? "3b" "3a") => #t)
      (check (debian-version->=? "3a" "3b") => #f)
      (check (debian-version->=? "3b" "3b") => #t)
      (check (debian-version->=? "3b" "3~") => #t)
      (check (debian-version->=? "3~" "3b") => #f)
      (check (debian-version->=? "3b" "3+") => #f)
      (check (debian-version->=? "3+" "3b") => #t)

      (check (version-satisfies-requirement? "2.1.3" '(< "2.1")) => #f)
      (check (version-satisfies-requirement? "2.0.3" '(< "2.1")) => #t)
      (check (version-satisfies-requirement? "2.1.3" '(> "2.1")) => #t)
      (check (version-satisfies-requirement? "2.0.3" '(> "2.1")) => #f)
      (check (version-satisfies-requirement? "2.1.3" '(<= "2.1")) => #f)
      (check (version-satisfies-requirement? "2.0.3" '(<= "2.1")) => #t)
      (check (version-satisfies-requirement? "2.0.3" '(<= "2.0.3")) => #t)
      (check (version-satisfies-requirement? "2.1.3" '(>= "2.1")) => #t)
      (check (version-satisfies-requirement? "2.0.3" '(>= "2.1")) => #f)
      (check (version-satisfies-requirement? "2.0.3" '(>= "2.0.3")) => #t)
      (check (version-satisfies-requirement? "2.0.3" '(not (>= "2.1"))) => #t)

      (check (version-satisfies-requirement?
              "2.0.3" '(and (> "2.0") (< "3.0.3"))) => #t)
      (check (version-satisfies-requirement?
              "2.0.3" '(or (> "2.0") (= "1.0.8"))) => #t)
      (check (version-satisfies-requirement?
              "1.0.8" '(or (> "2.0") (= "1.0.8"))) => #t)
      (check (version-satisfies-requirement?
              "1.0.9" '(or (> "2.0") (= "1.0.8"))) => #f)
      (check (version-satisfies-requirement?
              "1.0.9" '(not (or (> "2.0") (= "1.0.8")))) => #t)

      (check-passed? 130))))
