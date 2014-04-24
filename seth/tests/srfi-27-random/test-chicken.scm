#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "seth/srfi-27-random.sld")
(import (seth srfi-27-random))

(include "test-common.scm")

(display (main-program))
(newline)
