#! /bin/sh
#| -*- scheme -*-
CHIBI_MODULE_PATH="" exec chibi-scheme -A . -s $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (scheme file)
        (snow genport)
        (seth port-extras)
        (seth zlib))
(include "test-common.scm")
(display (main-program))
(newline)
