#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow srfi-19-time))


(include "test-common.scm")

(display (main-program))
(newline)
