#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/srfi-1-lists.sld")
(include "snow/bytevector.sld")
(include "snow/bignum.sld")
(include "snow/binio.sld")
;; (include "snow/random.sld")
(include "snow/genport.sld")
(include "snow/srfi-13-strings.sld")
(include "snow/srfi-60-integers-as-bits.sld")
(include "snow/filesys.sld")
(include "snow/tar.sld")
(import (snow tar))

(include "test-common.scm")

(display (main-program))
(newline)
