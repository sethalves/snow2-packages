#! /bin/sh
#| -*- scheme -*-
exec sash -A . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme file)
        (scheme write)
        (snow extio))
(include "test-common.scm")
(display (main-program))
(newline)
