#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/snowlib.sld")
(include "snow/bytevector.sld")
(include "snow/binio.sld")
(include "snow/extio.sld")
(import (scheme base)
        (scheme read)
        (snow bytevector)
        (snow extio))

(include "test-common.scm")

(display (main-program))
(newline)
