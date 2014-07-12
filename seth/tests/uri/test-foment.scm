#! /bin/sh
#| -*- scheme -*-
exec foment $0 "$@"
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
