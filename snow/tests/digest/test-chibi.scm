#! /bin/sh
#| -*- scheme -*-
CHIBI_MODULE_PATH="" exec chibi-scheme -A . -s $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (scheme char)
        (snow digest))
(import (scheme cxr))
(import (snow bytevector))
(include "test-common.scm")
(display (main-program))
(newline)
