#! /bin/sh
#| -*- scheme -*-
exec sash -A . -F .sld $0 "$@"
|#

(import (scheme base) (scheme write))
(import (snow bytevector))
(include "test-common.scm")
(display (main-program))
(newline)
