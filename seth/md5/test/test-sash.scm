#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme file)
        (scheme write)
        (seth md5))

(include "test-common.scm")

(display (main-program))
(newline)
