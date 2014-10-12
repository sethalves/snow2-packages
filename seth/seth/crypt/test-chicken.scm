#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

;; sudo chicken-install sha2

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))
(include "srfi/60.sld")
(include "snow/bytevector.sld")
(include "seth/crypt/sha-1.sld")
(include "seth/crypt/sha-2.sld")
(include "seth/crypt/md5.sld")
(include "seth/crypt/hmac-sha-1.sld")
(include "seth/crypt/tests.sld")
(import (seth crypt tests))
(display (run-tests))
(newline)
