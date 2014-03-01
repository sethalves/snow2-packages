#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (seth string-read-write)
        (snow srfi-29-format))


(include "test-common.scm")

(display (main-program))
(newline)
