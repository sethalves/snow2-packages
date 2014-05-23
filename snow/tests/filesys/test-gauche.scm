#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(append! *load-suffixes* (list ".sld"))' \
-e '(append! *load-path* (list "."))' \
-ftest -r7 $0 "$@"
|#

(import (scheme base)
        (scheme file)
        (scheme write)
        (srfi 1)
        (snow filesys))
(include "test-common.scm")
(display (main-program))
(newline)
