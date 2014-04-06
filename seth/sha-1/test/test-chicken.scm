#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))

(include "seth/sha-1.sld")
(import (seth sha-1))

(include "test-common.scm")

(display (main-program))
(newline)