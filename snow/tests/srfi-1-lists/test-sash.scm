#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow srfi-1-lists))
(import (snow bytevector))
(include "test-common.scm")
(display (main-program))
(newline)
