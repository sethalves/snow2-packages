#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))

(include "snow/bytevector.sld")
(include "snow/srfi-60-integers-as-bits.sld")
(include "seth/md5.sld")

(import (snow bytevector)
        (seth md5))

(include "test-common.scm")

(display (main-program))
(newline)
