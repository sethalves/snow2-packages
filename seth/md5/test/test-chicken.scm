#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base)
        (scheme file))
(include "snow/bytevector.sld")
(include "seth/md5.sld")
(import (snow bytevector))
(import (seth md5))

(include "test-common.scm")

(display (main-program))
(newline)
