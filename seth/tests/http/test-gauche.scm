#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(push! *load-suffixes* ".sld")' \
-e '(push! *load-path* ".")' \
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
