#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(append! *load-suffixes* (list ".sld"))' \
-e '(append! *load-path* (list "."))' \
-ftest -r7 $0 "$@"
|#

(import (scheme base)
        (scheme time)
        (scheme read)
        (scheme file)
        (scheme write))
(import (snow binio)
        (snow extio)
        (seth port-extras)
        (seth http))
(include "test-common.scm")
(display (main-program))
(newline)
