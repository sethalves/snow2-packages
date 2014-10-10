#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base)
        (scheme file))
(include "snow/filesys.sld")
(include "snow/filesys/tests.sld")
(import (snow filesys tests))
(display (run-tests))
(newline)
