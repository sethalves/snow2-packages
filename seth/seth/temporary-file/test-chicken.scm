#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(include "seth/temporary-file.sld")
(include "seth/temporary-file/tests.sld")
(import (seth temporary-file tests))
(display (run-tests))
(newline)
