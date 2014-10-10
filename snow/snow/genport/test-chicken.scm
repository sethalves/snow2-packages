#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))
(include "snow/bytevector.sld")
(include "snow/binio.sld")
(include "snow/genport.sld")
(include "snow/genport/tests.sld")
(import (snow genport tests))
(display (run-tests))
(newline)
