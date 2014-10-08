#! /bin/sh
#| -*- scheme -*-
exec sash -A . -F .sld $0 "$@"
|#

(import (scheme base) (scheme write))
(import (snow bytevector tests))
(display (run-tests))
(newline)
