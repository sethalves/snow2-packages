#! /bin/sh
#| -*- scheme -*-
exec sash -A . -F .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow assert))
(include "test-common.scm")
(display (main-program))
(newline)
