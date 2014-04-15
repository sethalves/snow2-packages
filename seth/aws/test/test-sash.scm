#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (seth aws common)
        (seth aws s3))

(include "test-common.scm")

(display (main-program))
(newline)