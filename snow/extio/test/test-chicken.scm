#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/extio.sld")
(import (snow extio))

(include "test-common.scm")

(display (main-program))
(newline)
