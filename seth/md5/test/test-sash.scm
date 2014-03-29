#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow bytevector)
        (seth md5))


(include "test-common.scm")

(display (main-program))
(newline)
