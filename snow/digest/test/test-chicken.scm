#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/bytevector.sld")
(include "snow/binio.sld")
(include "snow/srfi-60-integers-as-bits.sld")
(include "snow/digest.sld")
(import (snow digest))

(include "test-common.scm")

(display (main-program))
(newline)