#! /bin/sh
#| -*- scheme -*-
exec sash -A . -S .sld $0 "$@"
|#

(import (scheme base) (scheme write))
(import (seth port-extras))
(include "test-common.scm")
(display (main-program))
(newline)
