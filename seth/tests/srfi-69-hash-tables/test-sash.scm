#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (seth srfi-69-hash-tables))


(include "test-common.scm")

(display (main-program))
(newline)
