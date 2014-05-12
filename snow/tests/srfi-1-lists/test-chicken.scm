#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(use srfi-4)
(include "snow/srfi-1-lists.sld")
(import (scheme base)
        (snow srfi-1-lists))

(include "test-common.scm")

(display (main-program))
(newline)
