#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(include "srfi/60.sld")
(include "snow/bytevector.sld")
(include "snow/extio.sld")
(include "snow/extio/tests.sld")
(import (scheme base)
        (scheme write)
        (snow extio tests))
(display (run-tests))
(newline)
