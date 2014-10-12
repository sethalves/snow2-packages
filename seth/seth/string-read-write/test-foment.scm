#! /bin/sh
#| -*- scheme -*-
exec foment $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (seth string-read-write tests))
(display (run-tests))
(newline)
