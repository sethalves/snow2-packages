#! /bin/sh
#| -*- scheme -*-
exec foment $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (scheme process-context)
        (snow filesys)
        (snow extio)
        (snow assert)
        (snow processio))
(include "test-common.scm")
(display (main-program))
(newline)