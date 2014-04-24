#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(push! *load-suffixes* ".sld")' \
-e '(push! *load-path* ".")' \
-ftest -r7 $0 "$@"
|#

(import (scheme base)
        (scheme char)
        (scheme write))
(import (snow srfi-95-sort))
(include "test-common.scm")
(display (main-program))
(newline)
