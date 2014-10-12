#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))
(include "snow/bytevector.sld")
(include "seth/base64.sld")
(include "seth/base64/tests.sld")
(import (seth base64 tests))
(display (run-tests))
(newline)
