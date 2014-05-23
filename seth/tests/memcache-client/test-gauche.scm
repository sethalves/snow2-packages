#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(append! *load-suffixes* (list ".sld"))' \
-e '(append! *load-path* (list "."))' \
-ftest -r7 $0 "$@"
|#

(import (scheme base) (r7rs) (scheme read) (scheme write)
        (seth cout)
        (seth memcache-client)
        )

(include "test-common.scm")
(display (main-program))
(newline)
