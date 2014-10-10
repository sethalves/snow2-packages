#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(import (scheme base))
(include "srfi/60.sld")
(include "snow/bytevector.sld")
(include "snow/binio.sld")
(include "snow/genport.sld")
(include "snow/digest.sld")
(include "snow/zlib.sld")
(include "snow/zlib/tests.sld")
(import (snow zlib tests))
(display (run-tests))
(newline)
