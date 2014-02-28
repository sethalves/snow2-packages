#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/bytevector.sld")
(include "snow/binio.sld")
(include "snow/bignum.sld")
(include "snow/random.sld")
(import (snow random))

(include "test-common.scm")

(display (main-program))
(newline)
