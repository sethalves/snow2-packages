#! /bin/sh
#| -*- scheme -*-
CHIBI_MODULE_PATH="" exec chibi-scheme -A ../.. -s $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow hello tests))


(run-tests)
