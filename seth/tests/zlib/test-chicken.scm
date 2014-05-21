#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(import (scheme base)
        (scheme write)
        (scheme file))

(include "snow/srfi-1-lists.sld")
(include "snow/bytevector.sld")
(include "snow/binio.sld")
(include "snow/genport.sld")
(include "seth/port-extras.sld")
(include "seth/zlib.sld")


(import (snow genport)
        (seth port-extras)
        (seth zlib))



(include "test-common.scm")

(display (main-program))
(newline)
