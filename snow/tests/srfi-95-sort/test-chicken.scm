#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base)
        (scheme char))

(include "snow/srfi-1-lists.sld")
;; (include "snow/bytevector.sld")
(include "snow/srfi-95-sort.sld")
(import (snow srfi-95-sort))

(include "test-common.scm")

(display (main-program))
(newline)
