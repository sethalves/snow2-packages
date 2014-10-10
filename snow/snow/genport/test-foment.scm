#! /bin/sh
#| -*- scheme -*-
exec foment $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow genport tests))
(display (run-tests))
(newline)
