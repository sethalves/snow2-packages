#! /bin/sh
#| -*- scheme -*-
exec sash -A . -F .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (seth snow2 client))
(include "test-common.scm")
(display (main-program))
(newline)
