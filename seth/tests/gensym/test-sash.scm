#! /bin/sh
#| -*- scheme -*-
exec sash -A . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (seth gensym))


(include "test-common.scm")

(display (main-program))
(newline)
