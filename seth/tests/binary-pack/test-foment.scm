#! /bin/sh
#| -*- scheme -*-
exec foment $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow bytevector)
        (prefix (seth binary-pack) binary:))

(include "test-common.scm")

(display (main-program))
(newline)
