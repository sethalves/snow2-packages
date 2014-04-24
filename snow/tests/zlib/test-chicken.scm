#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/snowlib.sld")
(include "snow/bytevector.sld")
(include "snow/binio.sld")
(include "snow/srfi-60-integers-as-bits.sld")
(include "snow/genport.sld")
(include "snow/digest.sld")
(include "snow/zlib.sld")
(import (snow bytevector))
(import (snow binio))
(import (snow genport))
(import (snow zlib))

(include "test-common.scm")

;; (main-program)
(display (main-program))
(newline)