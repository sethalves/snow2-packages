#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(append! *load-suffixes* (list ".sld"))' \
-e '(append! *load-path* (list "."))' \
-ftest -r7 $0 "$@"
|#

(import (scheme base) (scheme write))
(import (snow pi))
(include "test-common.scm")
(display (main-program))
(newline)