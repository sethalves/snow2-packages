#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(import (scheme base)
        (scheme write)
        (scheme file))

(include "snow/snowlib.sld")
(include "snow/bytevector.sld")
(include "snow/binio.sld")
(include "snow/genport.sld")
(include "seth/string-read-write.sld")
(include "seth/port-extras.sld")
(include "seth/zlib.sld")


(import (snow snowlib)
        (snow genport)
        (seth port-extras)
        (seth zlib))



(include "test-common.scm")

(display (main-program))
(newline)
