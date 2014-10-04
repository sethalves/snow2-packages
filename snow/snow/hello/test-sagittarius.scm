#! /bin/sh
#| -*- scheme -*-
exec sash -A ../.. -F .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow hello tests))

(run-tests)
