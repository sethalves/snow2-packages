#! /bin/sh
#| -*- scheme -*-
exec sash -A . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (srfi 13)
        (snow extio)
        (snow assert)
        (seth xml ssax)
        (seth xml sxpath))
(include "test-common.scm")
(display (main-program))
(newline)
