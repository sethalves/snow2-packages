#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "seth/tar.sld")
(include "seth/tar/tests.sld")
(import (seth tar tests))
(display (run-tests))
(newline)
