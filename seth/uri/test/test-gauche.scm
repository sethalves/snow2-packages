#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(push! *load-suffixes* ".sld")' \
-e '(push! *load-path* ".")' \
-ftest -r7 $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (srfi 1)
        (srfi 29)
        (snow snowlib)
        (seth string-read-write))
(import (seth uri))
(include "test-common.scm")
(display (main-program))
(newline)
