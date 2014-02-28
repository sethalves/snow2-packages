#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/bytevector.sld")
(include "snow/bignum.sld")
(import (snow bignum))

(include "test-common.scm")

(display (main-program))
(newline)
