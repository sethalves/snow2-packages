#! /bin/sh
#| -*- scheme -*-
CHIBI_MODULE_PATH="" exec chibi-scheme -A . -s $0 "$@"
|#

(import (scheme base) (scheme write) (seth string-read-write))


(include "test-common.scm")


(display (main-program))
(newline)
