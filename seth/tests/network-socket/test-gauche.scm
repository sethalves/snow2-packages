#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(append! *load-suffixes* (list ".sld"))' \
-e '(append! *load-path* (list "."))' \
-ftest -r7 $0 "$@"
|#

(import (scheme base) (r7rs) (scheme read) (scheme write)
        (srfi 27)
        (seth port-extras)
        )

;; (define-module blerg
;;   (export make-sockaddr)
;;   (use gauche.net)
;;   (define (make-sockaddr server port)
;;     (make <sockaddr-in> server port)))

(import (seth network-socket))

(include "test-common.scm")
(display (main-program))
(newline)
