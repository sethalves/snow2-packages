#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "srfi/60.sld")
(include "snow/bytevector.sld")
(include "snow/extio.sld")
(import (scheme base)
        (scheme read)
        (scheme file)
        (snow bytevector)
        (snow extio))

(include "test-common.scm")

(display (main-program))
(newline)
