
;; http://www.debian.org/doc/debian-policy/ch-controlfields.html#s-f-Version

(define-library (seth debian-version)
  (export make-debian-version
          debian-version?
          debian-version-epoch
          debian-version-upstream-version
          debian-version-debian-revision
          string->debian-version
          debian-version->string
          debian-version-<?
          debian-version->?
          debian-version-=?
          debian-version-<=?
          debian-version->=?
          )
  (import (scheme base)
          (except (srfi 13) string-copy string-map string-for-each
                  string-fill! string-copy! string->list)
          (srfi 14)
          (snow assert)
          ;; (seth cout)
          )

  (begin

    (define-record-type <debian-version>
      (make-debian-version~ epoch upstream-version debian-revision)
      debian-version?
      (epoch debian-version-epoch)
      (upstream-version debian-version-upstream-version)
      (debian-revision debian-version-debian-revision))


    (define chars (char-set-intersection char-set:letter char-set:ascii))
    (define not-chars (char-set-complement chars))
    (define digits (char-set-intersection char-set:digit char-set:ascii))
    (define not-digits (char-set-complement digits))
    (define epoch-chars (char-set-intersection char-set:digit char-set:ascii))
    (define not-epoch-chars (char-set-complement epoch-chars))
    (define upstream-version-chars (char-set-union
                                    (char-set-intersection
                                     char-set:letter+digit char-set:ascii)
                                    (list->char-set '(#\. #\+ #\- #\: #\~))))
    (define not-upstream-version-chars (char-set-complement
                                        upstream-version-chars))
    (define debian-revision-chars (char-set-union
                                   (char-set-intersection
                                    char-set:letter+digit char-set:ascii)
                                   (list->char-set '(#\+ #\. #\~))))
    (define not-debian-revision-chars (char-set-complement
                                       debian-revision-chars))

    (define string-section-chars (char-set-union
                                  (char-set-intersection
                                   char-set:letter char-set:ascii)
                                  (list->char-set '(#\. #\+ #\- #\: #\~))))
    (define not-string-section-chars (char-set-complement string-section-chars))



    (define (make-debian-version epoch upstream-version debian-revision)
      (snow-assert (string? epoch))
      (snow-assert (string? upstream-version))
      (snow-assert (string? debian-revision))
      (if (string-index epoch not-epoch-chars)
          (error "invalid character in debian version epoch" epoch))
      (if (string-index upstream-version not-upstream-version-chars)
          (error "invalid character in debian upstream version"
                 upstream-version))
      (if (= (string-length upstream-version) 0)
          (error "debian version upstream-version cannot be empty"
                 upstream-version))
      (if (not (char-set-contains?
                char-set:digit (string-ref upstream-version 0)))
          (error "debian version upstream-version must start with a digit"
                 upstream-version))
      (if (string-index debian-revision not-debian-revision-chars)
          (error "invalid character in debian revision" debian-revision))

      (make-debian-version~ epoch upstream-version debian-revision))


    (define (string->debian-version version-string)
      ;; parse a version string
      (snow-assert (string? version-string))
      (let ((colon-index (string-index version-string #\:))
            (hyphen-rindex (string-index-right version-string #\-)))
        (cond ((and (not colon-index) (not hyphen-rindex))
               (make-debian-version "0" version-string "0"))
              ((not colon-index)
               (make-debian-version
                "0"
                (substring version-string 0 hyphen-rindex)
                (substring version-string (+ hyphen-rindex 1)
                           (string-length version-string))))
              ((not hyphen-rindex)
               (make-debian-version
                (substring version-string 0 colon-index)
                (substring version-string (+ colon-index 1)
                           (string-length version-string))
                "0"))
              (else
               (make-debian-version
                (substring version-string 0 colon-index)
                (substring version-string (+ colon-index 1) hyphen-rindex)
                (substring version-string (+ hyphen-rindex 1)
                           (string-length version-string)))))))


    (define (debian-version->string dver)
      (let ((explicit-epoch
             (or (not (equal? (debian-version-epoch dver) "0"))
                 (string-index (debian-version-upstream-version dver) #\:)
                 (string-index (debian-version-debian-revision dver) #\:)))
            (explicit-revision
             (or (not (equal? (debian-version-debian-revision dver) "0"))
                 (string-index (debian-version-epoch dver) #\-)
                 (string-index (debian-version-upstream-version dver) #\-))))
        (cond ((and explicit-epoch explicit-revision)
               (string-append
                (debian-version-epoch dver) ":"
                (debian-version-upstream-version dver) "-"
                (debian-version-debian-revision dver)))
              (explicit-epoch
               (string-append
                (debian-version-epoch dver) ":"
                (debian-version-upstream-version dver)))
              (explicit-revision
               (string-append
                (debian-version-upstream-version dver) "-"
                (debian-version-debian-revision dver)))
              (else
               (debian-version-upstream-version dver)))))


    (define (debian-string-number-section-<? a b)
      (cond ((and (= (string-length a) 0) (= (string-length b) 0)) 'match)
            (else
             (let* ((a-section-end
                     (or (string-index a not-digits) (string-length a)))
                    (b-section-end
                     (or (string-index b not-digits) (string-length b)))
                    (a-section (substring a 0 a-section-end))
                    (b-section (substring b 0 b-section-end))
                    (a-val (string->number a-section))
                    (b-val (string->number b-section))
                    (a-rest (substring a a-section-end (string-length a)))
                    (b-rest (substring b b-section-end (string-length b))))

               ;; (cout "    a-val=" a-val ", b-val=" b-val "\n")

               (cond
                ((and (not a-val) (not b-val))
                 (debian-string-char-section-<? a-rest b-rest))
                ((not a-val) #t)
                ((not b-val) #f)
                ((< a-val b-val) #t)
                ((> a-val b-val) #f)
                (else
                 (debian-string-char-section-<? a-rest b-rest)))))))



    (define (debian-string-char-section-<? a b)
      (cond ((and (= (string-length a) 0) (= (string-length b) 0)) 'match)
            (else
             (let* ((a-section-end
                     (or (string-index a not-string-section-chars)
                         (string-length a)))
                    (b-section-end
                     (or (string-index b not-string-section-chars)
                         (string-length b)))
                    (a-section (substring a 0 a-section-end))
                    (b-section (substring b 0 b-section-end))
                    (a-rest (substring a a-section-end (string-length a)))
                    (b-rest (substring b b-section-end (string-length b))))
               (let loop ((a-section (string->list a-section))
                          (b-section (string->list b-section)))

                 ;; (cout "    '" a-section "' vs '" b-section "'\n")

                 (cond

                  ((and (null? a-section) (null? b-section))
                   ;; the character sections were the same, move
                   ;; on to number sections.
                   (debian-string-number-section-<? a-rest b-rest))

                  ((and (null? a-section) (eqv? (car b-section) #\~))
                   ;; ~ sorts earlier than end-of-section
                   #f)

                  ((and (null? b-section) (eqv? (car a-section) #\~))
                   ;; ~ sorts earlier than end-of-section
                   #t)

                  ((null? b-section) #f)

                  ((null? a-section) #t)

                  ((and (eqv? (car a-section) #\~)
                        (not (eqv? (car b-section) #\~)))
                   ;; ~ sorts to earlier than any other
                   #t)

                  ((and (not (eqv? (car a-section) #\~))
                        (eqv? (car b-section) #\~))
                   ;; ~ sorts to earlier than any other
                   #f)

                  ((and (char-set-contains? chars (car a-section))
                        (not (char-set-contains? chars (car b-section))))
                   ;; letters sort to earlier than non-letters
                   #t)

                  ((and (not (char-set-contains? chars (car a-section)))
                        (char-set-contains? chars (car b-section)))
                   ;; letters sort to earlier than non-letters
                   #f)

                  ((char<? (car a-section) (car b-section)) #t)

                  ((char<? (car b-section) (car a-section)) #f)

                  (else
                   (loop (cdr a-section) (cdr b-section)))))))))



    (define (debian-version-<? a-in b-in)
      (snow-assert (or (debian-version? a-in) (string? a-in)))
      (snow-assert (or (debian-version? b-in) (string? b-in)))

      ;; (cout "\n-----------  '" (debian-version->string a)
      ;;       "' vs '" (debian-version->string b) "'  -------\n")

      (let* ((a (if (debian-version? a-in) a-in
                    (string->debian-version a-in)))
             (b (if (debian-version? b-in) b-in
                    (string->debian-version b-in)))

             (epoch-test
              (lambda ()
                (debian-string-number-section-<? (debian-version-epoch a)
                                                 (debian-version-epoch b))))
             (upstream-test
              (lambda ()
                (debian-string-number-section-<?
                 (debian-version-upstream-version a)
                 (debian-version-upstream-version b))))

             (revision-test
              (lambda ()
                (debian-string-number-section-<?
                 (debian-version-debian-revision a)
                 (debian-version-debian-revision b))))

             (tests (list epoch-test upstream-test revision-test)))

        (let loop ((tests tests))
          (if (null? tests) #f
              (let ((test-result ((car tests))))
                (cond ((eq? test-result #t) #t)
                      ((eq? test-result #f) #f)
                      (else
                       ;; (cout "\n")
                       (loop (cdr tests)))))))))


    (define (debian-version->? a b)
      (debian-version-<? b a))


    (define (debian-version-=? a b)
      (and (not (debian-version-<? a b))
           (not (debian-version-<? b a))))


    (define (debian-version-<=? a b)
      (or (debian-version-<? a b)
          (not (debian-version-<? b a))))


    (define (debian-version->=? a b)
      (or (debian-version-<? b a)
          (not (debian-version-<? a b))))

    ))
