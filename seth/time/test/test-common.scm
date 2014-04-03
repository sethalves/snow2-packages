


(define (test-0)

  (let* ((now-seconds (seconds-since-epoch))
         (XXX (begin (display "now-seconds=") (write now-seconds) (newline)))
         (now-time (seconds->time-struct-utc now-seconds))
         (XXX (begin (display "now-time=") (write now-time) (newline)))
         (date-string
          (string-append
           (number->string (time-struct:year now-time)) "/"
           (number->string (+ (time-struct:month now-time) 1)) "/"
           (number->string (time-struct:month-day now-time))))
         (XXX (begin (display "date-string=") (write date-string) (newline)))
         )
    (cout "year=" (time-struct:year now-time) "\n")
    (cout "month=" (+ (time-struct:month now-time) 1) "\n")
    (cout "day=" (time-struct:month-day now-time) "\n")
    (cout "week-day=" (time-struct:week-day now-time) "\n")
    (cout "date=" date-string "\n")


  #t))


;; (define (test-1)
;;   (let (;; (parse-rfc2616-date3 (rfc2616-date:make-parser-date3))
;;         ;; (parse-rfc2616-date2 (rfc2616-date:make-parser-date2))
;;         ;; (parse-rfc2616-date1 (rfc2616-date:make-parser-date1))
;;         (parse-rfc2616-asctime-date (rfc2616-date:make-parser-asctime-date))
;;         (parse-rfc2616-rfc850-date (rfc2616-date:make-parser-rfc850-date))
;;         (parse-rfc2616-rfc1123-date (rfc2616-date:make-parser-rfc1123-date)))

;;     ;; (print-parse-state (parse-rfc2616-date3
;;     ;;                     (new-parse-state-from-string "Jan 22")))
;;     ;; (print-parse-state (parse-rfc2616-date3
;;     ;;                     (new-parse-state-from-string "Jan  2")))
;;     ;; (print-parse-state (parse-rfc2616-date2
;;     ;;                     (new-parse-state-from-string "02-Jun-82")))
;;     ;; (print-parse-state (parse-rfc2616-date1
;;     ;;                     (new-parse-state-from-string "02 Jun 1982")))

;;     ;; (print-parse-state (parse-rfc2616-asctime-date
;;     ;;                     (new-parse-state-from-string
;;     ;;                      "Mon Jul  4 23:59:59 1972")))

;;     ;; (print-parse-state (parse-rfc2616-rfc850-date
;;     ;;                     (new-parse-state-from-string
;;     ;;                      "Monday, 02-Jun-82 12:11:10 GMT")))

;;     ;; (print-parse-state (parse-rfc2616-rfc1123-date
;;     ;;                     (new-parse-state-from-string
;;     ;;                      "Mon, 02 Jun 1982 09:08:07 GMT")))

;;     (and
;;      (equal? (time-struct->list
;;               (parse-state-value
;;                (parse-rfc2616-asctime-date
;;                 (new-parse-state-from-string
;;                  "Mon Jul  4 23:59:59 1972"))))
;;              (list 59 59 23 4 6 1972 0 #f #f #f))

;;      (equal? (time-struct->list
;;               (parse-state-value
;;                (parse-rfc2616-rfc850-date
;;                 (new-parse-state-from-string
;;                  "Monday, 02-Jun-82 12:11:10 GMT"))))
;;              (list 10 11 12 2 5 1982 0 #f #f #f))

;;      (equal? (time-struct->list
;;               (parse-state-value
;;                (parse-rfc2616-rfc1123-date
;;                 (new-parse-state-from-string
;;                  "Mon, 02 Jun 1983 09:08:07 GMT"))))
;;              (list 7 8 9 2 5 1983 0 #f #f #f))

;;      )))


(define (main-program)
  (and
   (test-0)
   ;; (test-1)
   #t))
