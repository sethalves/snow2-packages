#! /bin/sh
#| -*- scheme -*-
exec foment -A . $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow pi tests))
(display (run-tests))
(newline)
