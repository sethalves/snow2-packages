#! /bin/sh
#| -*- scheme -*-
exec foment $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow bytevector)
        (prefix (seth base64) base64:))
(include "test-common.scm")
(display (main-program))
(newline)
