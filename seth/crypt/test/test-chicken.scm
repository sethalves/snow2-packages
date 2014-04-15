#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base)
        (scheme file)
        )

(include "snow/bytevector.sld")
(include "seth/crypt/sha-1.sld")
(include "seth/crypt/md5.sld")
(include "seth/crypt/hmac-sha-1.sld")
(import (snow bytevector)
        (seth crypt sha-1)
        (seth crypt md5)
        (seth crypt hmac-sha-1))

(include "test-common.scm")

(display (main-program))
(newline)
