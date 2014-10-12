#! /bin/sh
#| -*- scheme -*-
exec sash -A . -F .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (seth network-socket tests))
(display (run-tests))
(newline)
