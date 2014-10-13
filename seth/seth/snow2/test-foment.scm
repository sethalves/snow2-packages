#! /bin/sh
#| -*- scheme -*-
exec foment $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (seth snow2 tests))
(display (run-tests))
(newline)
