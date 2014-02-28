#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(push! *load-suffixes* ".sld")' \
-e '(push! *load-path* ".")' \
-ftest -r7 $0 "$@"
|#

(import (scheme base) (scheme write) (scheme char))
(import (srfi 14))
(import (snow srfi-13-strings))
(include "test-common.scm")
(display (main-program))
(newline)
