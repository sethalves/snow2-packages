#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(push! *load-suffixes* ".sld")' \
-e '(push! *load-path* ".")' \
-ftest -r7 $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow bytevector)
        (seth uuid)
        (srfi 27)
        (srfi 60)
        )
(include "test-common.scm")
(display (main-program))
(newline)
