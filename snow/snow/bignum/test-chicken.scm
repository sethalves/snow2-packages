#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(include "snow/bytevector.sld")
(include "snow/bignum.sld")
(include "snow/bignum/tests.sld")
(import (snow bignum tests))
(display (run-tests))
(newline)
