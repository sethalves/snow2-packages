#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))
(include "seth/gensym.sld")
(include "seth/gensym/tests.sld")
(import (seth gensym tests))
(display (run-tests))
(newline)
