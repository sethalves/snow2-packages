#! /bin/sh
#| -*- scheme -*-
exec sash -A . -F .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow zlib))
(import (snow genport) (snow binio))

(include "test-common.scm")

(display (main-program))
(newline)
