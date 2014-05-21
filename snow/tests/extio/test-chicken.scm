#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/srfi-1-lists.sld")
(include "snow/bytevector.sld")
(include "snow/srfi-13-strings.sld")
(include "snow/srfi-60-integers-as-bits.sld")
(include "snow/extio.sld")
(import (scheme base)
        (scheme read)
        (scheme file)
        (snow bytevector)
        (snow extio))

(include "test-common.scm")

(display (main-program))
(newline)
