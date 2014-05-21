#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(push! *load-suffixes* ".sld")' \
-e '(push! *load-path* ".")' \
-ftest -r7 $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow srfi-13-strings)
        (seth crypt md5)
        (seth http)
        (seth aws common)
        (seth aws s3))
(include "test-common.scm")
(display (main-program))
(newline)
