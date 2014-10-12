#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))
(include "snow/bytevector.sld")
(include "seth/binary-pack.sld")
(include "seth/binary-pack/tests.sld")
(import (snow bytevector))
(import (seth binary-pack tests))
(display (run-tests))
(newline)
