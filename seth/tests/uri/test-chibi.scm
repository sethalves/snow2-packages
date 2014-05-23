#! /bin/sh
#| -*- scheme -*-
CHIBI_MODULE_PATH="" exec chibi-scheme -A . -s $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (srfi 1)
        (srfi 29)
        (seth string-read-write))
(import (seth uri))
(include "test-common.scm")
(display (main-program))
(newline)
