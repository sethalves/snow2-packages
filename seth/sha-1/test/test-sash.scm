#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (seth sha-1))


(include "test-common.scm")

(display (main-program))
(newline)
