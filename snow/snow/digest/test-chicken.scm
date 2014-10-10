#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "srfi/60.sld")
(include "snow/bytevector.sld")
(include "snow/binio.sld")
(include "snow/digest.sld")
(include "snow/digest/tests.sld")
(import (snow digest tests))
(display (run-tests))
(newline)
