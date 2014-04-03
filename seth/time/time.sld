
(define-library (seth time)
  (export
   time-struct->list list->time-struct time-struct:combine
   time-struct:new time-struct:is-type?
   time-struct:seconds time-struct:set-seconds!
   time-struct:minutes time-struct:set-minutes!
   time-struct:hours time-struct:set-hours!
   time-struct:month-day time-struct:set-month-day!
   time-struct:month time-struct:set-month!
   time-struct:year time-struct:set-year!
   time-struct:week-day time-struct:set-week-day!
   time-struct:year-day time-struct:set-year-day!
   time-struct:dst-flag time-struct:set-dst-flag!
   time-struct:timezone time-struct:set-timezone!

   seconds-since-epoch
   format-time
   seconds->time-struct-utc
   time-struct->list
   list->time-struct
   time-struct:combine)

  (import (scheme base))
  (cond-expand
   (chibi
    (import (chibi time) (chibi io)))
   (chicken
    (import (chicken) (posix) (srfi 4)))
   (gauche
    (import (srfi 19)))
   (sagittarius
    (import (scheme time) (srfi 19))))

  (begin

    (define-record-type time-struct
      (time-struct:new seconds minutes hours month-day month
                       year week-day year-day dst-flag timezone)
      time-struct:is-type?
      ;; the number of seconds after the minute (0 - 59)
      (seconds time-struct:seconds time-struct:set-seconds!)
      ;; the number of minutes after the hour (0 - 59)
      (minutes time-struct:minutes time-struct:set-minutes!)
      ;; the number of hours past midnight (0 - 23)
      (hours time-struct:hours time-struct:set-hours!)
      ;; the day of the month (1 - 31)
      (month-day time-struct:month-day time-struct:set-month-day!)
      ;; the number of months since january (0 - 11)
      (month time-struct:month time-struct:set-month!)
      ;; year
      (year time-struct:year time-struct:set-year!)
      ;; the number of days since Sunday (0 - 6)
      (week-day time-struct:week-day time-struct:set-week-day!)
      ;; the number of days since January 1 (0 - 365)
      (year-day time-struct:year-day time-struct:set-year-day!)
      ;; true if Daylight Saving Time is in effect at the time described.
      (dst-flag time-struct:dst-flag time-struct:set-dst-flag!)
      ;; the difference between UTC and the latest local standard time,
      ;; in seconds west of UTC.
      (timezone time-struct:timezone time-struct:set-timezone!))


    (cond-expand
     (chicken
      (define seconds-since-epoch
        (let ((start-time (current-seconds))
              (start-ms (current-milliseconds)))
          (lambda ()
            (+ (/ (- (current-milliseconds) start-ms) 1000) start-time))))

      (define (format-time fmt epoch-time)
        (time->string (seconds->utc-time epoch-time) fmt))


      (define (seconds->time-struct-utc seconds)
        ;; (seconds->local-time [SECONDS])
        (let ((tm (seconds->utc-time seconds)))
          (time-struct:new
           (vector-ref tm 0)
           (vector-ref tm 1)
           (vector-ref tm 2)
           (vector-ref tm 3)
           (vector-ref tm 4)
           (+ (vector-ref tm 5) 1900) ;; agh!  can't spare the byte!
           (vector-ref tm 6)
           (vector-ref tm 7)
           (vector-ref tm 8)
           (vector-ref tm 9)))))


     (chibi
      (define (seconds-since-epoch)
        (current-seconds))
      (define (format-time fmt epoch-time)
        ;; XXX get access to strftime
        (seconds->string epoch-time))
      (define (seconds->time-struct-utc seconds)
        (let ((tm (seconds->time seconds)))
          (time-struct:new
           (time-second tm)
           (time-minute tm)
           (time-hour tm)
           (time-day tm)
           (time-month tm)
           (+ (time-year tm) 1900)
           (time-day-of-week tm)
           (time-day-of-year tm)
           (time-dst? tm)
           0 ;; tz offset
           ))))


     (sagittarius
      (define (seconds-since-epoch) (current-second))
      (define (format-time fmt epoch-time)
        (date->string
         (time-utc->date (seconds->time epoch-time))
         (list->string
          (map
           (lambda (c)
             (cond ((eqv? c #\%) #\~)
                   (else c)))
           (string->list fmt)))))
      (define (seconds->time-struct-utc seconds)
        (seconds->time secodns)
        )
      )


     (gauche
      (define (seconds-since-epoch)
        (sys-time)
        ;; sys-gmtime
        )

      (define (format-time fmt epoch-time)
        (date->string
         (time-utc->date (seconds->time epoch-time))
         (list->string
          (map
           (lambda (c)
             (cond ((eqv? c #\%) #\~)
                   (else c)))
           (string->list fmt))))))

     (define (seconds->time-struct-utc seconds)
       #f)
     )



    (define (time-struct->list ts)
      (list (time-struct:seconds ts)
            (time-struct:minutes ts)
            (time-struct:hours ts)
            (time-struct:month-day ts)
            (time-struct:month ts)
            (time-struct:year ts)
            (time-struct:week-day ts)
            (time-struct:year-day ts)
            (time-struct:dst-flag ts)
            (time-struct:timezone ts)))


    (define (list->time-struct lst)
      (apply time-struct:new lst))


    (define (time-struct:combine a b)
      ;; b overrides a, unless b is #f
      (time-struct:new (if (time-struct:seconds b)
                           (time-struct:seconds b)
                           (time-struct:seconds a))
                       (if (time-struct:minutes b)
                           (time-struct:minutes b)
                           (time-struct:minutes a))
                       (if (time-struct:hours b)
                           (time-struct:hours b)
                           (time-struct:hours a))
                       (if (time-struct:month-day b)
                           (time-struct:month-day b)
                           (time-struct:month-day a))
                       (if (time-struct:month b)
                           (time-struct:month b)
                           (time-struct:month a))
                       (if (time-struct:year b)
                           (time-struct:year b)
                           (time-struct:year a))
                       (if (time-struct:week-day b)
                           (time-struct:week-day b)
                           (time-struct:week-day a))
                       (if (time-struct:year-day b)
                           (time-struct:year-day b)
                           (time-struct:year-day a))
                       (if (time-struct:dst-flag b)
                           (time-struct:dst-flag b)
                           (time-struct:dst-flag a))
                       (if (time-struct:timezone b)
                           (time-struct:timezone b)
                           (time-struct:timezone a))))

    (cond-expand (chicken (register-feature! 'seth.time)) (else))
    ))
