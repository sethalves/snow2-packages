#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/bytevector.sld")
(include "snow/binio.sld")
(include "snow/genport.sld")
(import (snow genport))

(include "test-common.scm")

(display (main-program))
(newline)
