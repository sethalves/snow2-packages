#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "seth/tar.sld")
(import (seth tar))

(include "test-common.scm")

(display (main-program))
(newline)
