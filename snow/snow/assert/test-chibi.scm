#! /bin/sh
#| -*- scheme -*-
CHIBI_MODULE_PATH="" exec chibi-scheme -A ../.. -s $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow assert)
        (snow assert tests))

(display (run-tests))
(newline)
