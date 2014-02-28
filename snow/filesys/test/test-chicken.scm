#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(import (scheme file))

(include "snow/bytevector.sld")
(include "snow/bignum.sld")
(include "snow/binio.sld")
(include "snow/random.sld")
(include "snow/srfi-13-strings.sld")
(include "snow/filesys.sld")
(import (snow filesys))

(include "test-common.scm")

(display (main-program))
(newline)
