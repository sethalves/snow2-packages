#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(include "srfi/60.sld")
(include "snow/bytevector.sld")
(include "snow/extio.sld")
(include "seth/alexpander.sld")
(include "seth/alexpander/tests.sld")
(import (seth alexpander tests))
(display (run-tests))
(newline)
