#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(append! *load-suffixes* (list ".sld"))' \
-e '(append! *load-path* (list "."))' \
-ftest -r7 $0 "$@"
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
