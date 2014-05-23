#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))

(define flush-output-port flush-output)

(include "snow/bytevector.sld")
(include "seth/port-extras.sld")
(import (seth port-extras))

(include "test-common.scm")

(display (main-program))
(newline)
