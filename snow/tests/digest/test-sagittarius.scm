#! /bin/sh
#| -*- scheme -*-
exec sash -A . -F .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (scheme char)
        (snow digest))
(import (scheme cxr))
(import (snow bytevector))
(include "test-common.scm")
(display (main-program))
(newline)
