#! /bin/sh
#| -*- scheme -*-
exec foment $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow binio)
        (snow genport)
        (snow zlib))
(include "test-common.scm")
(display (main-program))
(newline)
