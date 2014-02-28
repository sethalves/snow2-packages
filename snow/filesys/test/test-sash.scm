#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme file)
        (scheme write)
        (snow filesys))


(include "test-common.scm")

(display (main-program))
(newline)
