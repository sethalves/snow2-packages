#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))
(include "srfi/60.sld")
(include "snow/assert.sld")
(include "snow/bytevector.sld")
(include "snow/binio.sld")
(include "snow/filesys.sld")
(include "snow/extio.sld")
(include "snow/processio.sld")
(include "snow/processio/tests.sld")
(import (snow processio tests))
(display (run-tests))
(newline)
