#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (srfi 14))
(import (snow srfi-13-strings))
(include "test-common.scm")
(display (main-program))
(newline)
