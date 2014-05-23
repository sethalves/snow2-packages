#! /bin/sh
#| -*- scheme -*-
exec sash -A . -S .sld $0 "$@"
|#

(import (scheme base) (scheme write))
(import (seth snow2-utils))
(include "test-common.scm")
(display (main-program))
(newline)
