#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))
(include "snow/assert.sld")
(include "snow/input-parse.sld")
(include "seth/model-3d.sld")
(include "seth/model-3d/tests.sld")
(import (seth model-3d tests))
(display (run-tests))
(newline)
