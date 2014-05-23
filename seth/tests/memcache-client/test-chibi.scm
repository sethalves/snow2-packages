#! /bin/sh
#| -*- scheme -*-
CHIBI_MODULE_PATH="" exec chibi-scheme -A . -s $0 "$@"
|#

(import (scheme base) (scheme write)
        (seth memcache-client)
        (seth cout))
(include "test-common.scm")
(main-program)
