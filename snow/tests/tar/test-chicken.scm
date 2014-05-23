#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(import (scheme base))
(include "srfi/60.sld")
(include "snow/bytevector.sld")
(include "snow/bignum.sld")
(include "snow/binio.sld")
;; (include "snow/random.sld")
(include "snow/genport.sld")
(include "snow/filesys.sld")
(include "snow/tar.sld")
(import (snow tar))

(include "test-common.scm")

(display (main-program))
(newline)
