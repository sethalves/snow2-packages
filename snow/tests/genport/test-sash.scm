#! /bin/sh
#| -*- scheme -*-
exec sash -A . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow genport))
(include "test-common.scm")
(display (main-program))
(newline)
