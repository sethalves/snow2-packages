#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow bytevector)
        (seth crypt sha-1)
        (seth crypt md5))
(include "test-common.scm")
(display (main-program))
(newline)
