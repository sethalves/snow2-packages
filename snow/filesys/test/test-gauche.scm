#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(push! *load-suffixes* ".sld")' \
-e '(push! *load-path* ".")' \
-ftest -r7 $0 "$@"
|#

(import (scheme base) (scheme file) (scheme write))
(import (snow filesys))
(include "test-common.scm")
(display (main-program))
(newline)
