#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/bytevector.sld")
(include "snow/bignum.sld")
(include "snow/pi.sld")
(include "snow/hello.sld")
(import (snow hello))

(include "test-common.scm")

(display (main-program))
(newline)