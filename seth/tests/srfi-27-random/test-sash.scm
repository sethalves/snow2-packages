#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base) (scheme write))
(import (seth srfi-27-random))
(include "test-common.scm")
(display (main-program))
(newline)
