#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(include "seth/string-read-write.sld")
(include "seth/string-read-write/tests.sld")
(import (seth string-read-write tests))
(display (run-tests))
(newline)
