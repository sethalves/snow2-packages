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
(include "snow/genport.sld")
(include "snow/filesys.sld")
(include "snow/tar.sld")
(include "snow/tar/tests.sld")
(import (snow tar tests))
(display (run-tests))
(newline)
