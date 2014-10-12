#! /bin/sh
#| -*- scheme -*-
exec foment $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (seth http tests))
(display (run-tests))
(newline)
