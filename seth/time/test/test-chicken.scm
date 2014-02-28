#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(use posix)

(include "seth/time.sld")
(include "seth/cout.sld")
(import (seth time) (seth cout))

(include "test-common.scm")

(display (main-program))
(newline)
