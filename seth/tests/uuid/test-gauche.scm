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
        (seth srfi-27-random)
        (snow srfi-60-integers-as-bits)
        )
(include "test-common.scm")
(display (main-program))
(newline)
