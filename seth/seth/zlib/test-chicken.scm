#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

;; sudo chicken-install z3

(use r7rs)
(import-for-syntax r7rs)

(import (scheme base)
        (scheme write))
(include "snow/bytevector.sld")
(include "snow/binio.sld")
(include "snow/genport.sld")
(include "seth/port-extras.sld")
(include "seth/zlib.sld")
(include "seth/zlib/tests.sld")
(import (seth zlib tests))
(display (run-tests))
(newline)
