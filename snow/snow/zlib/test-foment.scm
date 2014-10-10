#! /bin/sh
#| -*- scheme -*-
exec foment $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow zlib tests))
(display (run-tests))
(newline)
