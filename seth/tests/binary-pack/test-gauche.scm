#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(push! *load-suffixes* ".sld")' \
-e '(push! *load-path* ".")' \
-ftest -r7 $0 "$@"
|#

(import (scheme base) (scheme write) (snow bytevector))
(import (prefix (seth binary-pack) binary:))
(include "test-common.scm")
(display (main-program))
(newline)
