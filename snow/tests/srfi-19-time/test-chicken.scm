#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))

(include "snow/srfi-19-time.sld")
(import (snow srfi-19-time))

(include "test-common.scm")

(display (main-program))
(newline)
