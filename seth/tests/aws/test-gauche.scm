#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(append! *load-suffixes* (list ".sld"))' \
-e '(append! *load-path* (list "."))' \
-ftest -r7 $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (srfi 13)
        (seth crypt md5)
        (seth http)
        (seth aws common)
        (seth aws s3))
(include "test-common.scm")
(display (main-program))
(newline)
