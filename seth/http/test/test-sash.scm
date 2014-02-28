#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base) (scheme write) (scheme file))
(import (seth port-extras) (seth http))
(include "test-common.scm")
(display (main-program))
(newline)
