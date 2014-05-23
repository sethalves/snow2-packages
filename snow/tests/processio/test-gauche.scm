#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(append! *load-suffixes* (list ".sld"))' \
-e '(append! *load-path* (list "."))' \
-ftest -r7 $0 "$@"
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
