#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "seth/temporary-file.sld")
(import (seth temporary-file))

(include "test-common.scm")

(display (main-program))
(newline)
