#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "seth/string-read-write.sld")
(include "seth/uri.sld")
(import (scheme base)
        (srfi 29))
(import (seth uri))

(include "test-common.scm")

(display (main-program))
(newline)
