#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/snowlib.sld")
(include "snow/input-parse.sld")
(import (snow input-parse))

(include "test-common.scm")

(display (main-program))
(newline)
