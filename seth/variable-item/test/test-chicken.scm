#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))

(include "seth/variable-item.sld")
(import (seth variable-item))

(include "test-common.scm")

(display (main-program))
(newline)
