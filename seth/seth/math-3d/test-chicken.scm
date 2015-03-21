#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))
(include "seth/cout.sld")
(include "seth/math-3d.sld")
(include "seth/math-3d/tests.sld")
(import (seth math-3d tests))
(display (run-tests))
(newline)
