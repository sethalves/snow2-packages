#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/snowlib.sld")
(import (snow snowlib))


(include "snow/assert.sld")
(import (snow assert))

(include "test-common.scm")

(display (main-program))
(newline)
