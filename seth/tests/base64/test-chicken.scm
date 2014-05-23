#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/bytevector.sld")
(include "seth/base64.sld")
(import (snow bytevector))
(import (prefix (seth base64) base64:))

(include "test-common.scm")

(display (main-program))
(newline)
