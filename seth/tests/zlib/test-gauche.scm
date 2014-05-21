#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(push! *load-suffixes* ".sld")' \
-e '(push! *load-path* ".")' \
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
