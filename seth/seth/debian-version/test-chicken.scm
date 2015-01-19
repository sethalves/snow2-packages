#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))
(include "srfi/42.sld")
(include "srfi/78.sld")
(include "snow/assert.sld")
(include "snow/bytevector.sld")
(include "seth/debian-version.sld")
(include "seth/debian-version/tests.sld")
(import (seth debian-version tests))
(display (run-tests))
(newline)
