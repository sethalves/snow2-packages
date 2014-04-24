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
        (seth message-digest primitive)
        (seth message-digest type)
        (seth message-digest bv)
        (seth message-digest port)
        (seth message-digest md5))
(include "test-common.scm")
(display (main-program))
(newline)
