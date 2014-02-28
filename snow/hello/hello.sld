;;;============================================================================

;;; File: "hello.scm", Time-stamp: <2007-04-04 17:32:53 feeley>

;;; Copyright (c) 2006-2007 by Marc Feeley, All Rights Reserved.

;;;============================================================================

;; The universal small example.  A self-contained program that
;; displays "let it snow" and the first few digits of pi.
;;
;; You can run this program like this:
;;
;;   % cd examples
;;   % snowrun -- hello/snow/hello.scm
;;   let it snow
;;   314159265358979323803


(define-library (snow hello)
  (export) ;;sagittarius requires an export
  (import (scheme base))
  (import (scheme write))
  (import (snow pi))
  (begin

;;;============================================================================

(define (hello-world)
  (display "let it snow")
  (newline)
  (display (substring (pi-digits 20) 0 15))
  (newline))

(hello-world)

;;;============================================================================

))
