#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))
(include "seth/deep-copy.sld")
(import (seth deep-copy))
(include "test-common.scm")
(display (main-program))
(newline)
