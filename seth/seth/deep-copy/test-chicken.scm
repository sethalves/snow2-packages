#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))
(include "seth/deep-copy.sld")
(include "seth/deep-copy/tests.sld")
(import (seth deep-copy tests))
(display (run-tests))
(newline)
