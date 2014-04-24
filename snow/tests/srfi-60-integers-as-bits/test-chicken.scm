#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/srfi-60-integers-as-bits.sld")
(import (snow srfi-60-integers-as-bits))

(include "test-common.scm")

(display (main-program))
(newline)
