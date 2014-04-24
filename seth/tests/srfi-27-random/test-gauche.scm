#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(push! *load-suffixes* ".sld")' \
-e '(push! *load-path* ".")' \
-ftest -r7 $0 "$@"
|#

(import (scheme base) (scheme write) (seth srfi-27-random))
;; (import (scheme base) (scheme write) (srfi-27))
(include "test-common.scm")
(display (main-program))
(newline)
