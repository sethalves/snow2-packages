#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))
(include "snow/assert.sld")
(include "snow/input-parse.sld")
(include "seth/stl-model.sld")
(include "seth/stl-model/tests.sld")
(import (seth stl-model tests))
(display (run-tests))
(newline)
