#! /bin/sh
#| -*- scheme -*-
CHIBI_MODULE_PATH="" exec chibi-scheme -A . -s $0 "$@"
|#

(import (scheme base)
        (scheme time)
        (scheme read)
        (scheme file)
        (scheme write)
        (snow binio)
        (snow extio)
        (seth port-extras)
        (seth http))
(include "test-common.scm")
(display (main-program))
(newline)
