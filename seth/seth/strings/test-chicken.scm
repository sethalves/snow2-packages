#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))
(include "snow/assert.sld")
(include "snow/input-parse.sld")
(include "seth/strings.sld")
(include "seth/strings/tests.sld")
(import (seth strings tests))
(display (run-tests))
(newline)
