#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(import (scheme base))

(include "../../snow/assert.sld")
(include "../../snow/assert/tests.sld")
(import (snow assert tests))

(display (run-tests))
(newline)
