;; -*- scheme -*-

(define-library (seth string-read-write)
  (export read-from-string write-to-string display-to-string ->string)
  (import (scheme base) (scheme read) (scheme write))
  (begin

    (define (read-from-string s)
      (read (open-input-string s)))

    (define (write-to-string obj)
      (let ((s (open-output-string)))
        (write obj s)
        (let ((result (get-output-string s)))
          (close-output-port s)
          result)))

    (define (display-to-string obj)
      (let ((s (open-output-string)))
        (display obj s)
        (let ((result (get-output-string s)))
          (close-output-port s)
          result)))

    (define ->string display-to-string)

    ))
