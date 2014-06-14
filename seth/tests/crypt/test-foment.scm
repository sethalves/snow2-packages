#! /bin/sh
#| -*- scheme -*-
exec foment $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow bytevector)
        (seth crypt sha-1)
        (seth crypt sha-2)
        (seth crypt md5)
        (seth crypt hmac-sha-1))
(include "test-common.scm")
(display (main-program))
(newline)