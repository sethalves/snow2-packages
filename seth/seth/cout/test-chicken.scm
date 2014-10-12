#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(include "seth/cout.sld")
(include "seth/cout/tests.sld")
(import (seth cout tests))
(display (run-tests))
(newline)
