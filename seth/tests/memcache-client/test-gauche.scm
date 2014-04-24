#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(push! *load-suffixes* ".sld")' \
-e '(push! *load-path* ".")' \
-ftest -r7 $0 "$@"
|#

(import (scheme base) (r7rs) (scheme read) (scheme write)
        (seth cout)
        (seth memcache-client)
        )

(include "test-common.scm")
(display (main-program))
(newline)
