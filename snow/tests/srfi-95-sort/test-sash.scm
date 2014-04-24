#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme char)
        (scheme write)
        (snow srfi-95-sort))


(include "test-common.scm")

(display (main-program))
(newline)
