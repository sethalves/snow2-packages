#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))

(include "seth/gensym.sld")
(import (seth gensym))

(include "test-common.scm")

(display (main-program))
(newline)
