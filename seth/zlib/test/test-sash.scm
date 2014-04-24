#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (scheme file)
        (snow snowlib)
        (snow genport)
        (seth port-extras)
        (seth zlib))

(include "test-common.scm")

(display (main-program))
(newline)
