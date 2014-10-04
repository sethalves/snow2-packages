#! /bin/sh
#| -*- scheme -*-
exec foment -A ../.. $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow hello tests))

(run-tests)
