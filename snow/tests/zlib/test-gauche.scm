#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(append! *load-suffixes* (list ".sld"))' \
-e '(append! *load-path* (list "."))' \
-ftest -r7 $0 "$@"
|#

(import (scheme base) (scheme write))
(import (snow binio))
(import (snow genport))
(import (snow zlib))
(include "test-common.scm")
(display (main-program))
(newline)
