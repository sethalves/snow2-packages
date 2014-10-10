#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(include "snow/input-parse.sld")
(include "snow/input-parse/tests.sld")
(import (snow input-parse tests))
(display (run-tests))
(newline)
