#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/snowlib.sld")
(include "snow/srfi-29-format.sld")
(import (snow srfi-29-format))

(include "test-common.scm")

(display (main-program))
(newline)