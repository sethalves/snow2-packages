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
(include "snow/random/tests.sld")
(import (snow random tests))
(display (run-tests))
(newline)
