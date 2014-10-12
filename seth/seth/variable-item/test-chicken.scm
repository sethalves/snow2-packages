#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))
(include "seth/variable-item.sld")
(include "seth/variable-item/tests.sld")
(import (seth variable-item tests))
(display (run-tests))
(newline)
