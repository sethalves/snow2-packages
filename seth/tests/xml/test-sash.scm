#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow srfi-13-strings)
        (snow extio)
        (snow assert)
        (seth xml ssax)
        (seth xml sxpath))


(include "test-common.scm")

(display (main-program))
(newline)
