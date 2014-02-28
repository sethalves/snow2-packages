#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "seth/string-read-write.sld")
(import (seth string-read-write))

(include "test-common.scm")

(display (main-program))
(newline)
