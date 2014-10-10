#! /bin/sh
#| -*- scheme -*-
exec foment $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow input-parse tests))
(display (run-tests))
(newline)
