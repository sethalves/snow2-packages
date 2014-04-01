#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))

(include "snow/bytevector.sld")
(include "seth/md5.sld")
(import (seth md5))

(include "test-common.scm")

(display (main-program))
(newline)
