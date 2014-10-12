#! /bin/sh
#| -*- scheme -*-
exec foment $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (seth binary-pack tests))
(display (run-tests))
(newline)
