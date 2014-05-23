#! /bin/sh
#| -*- scheme -*-
exec sash -A . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (scheme file)
        (seth cout)
        (seth memcache-client))
(include "test-common.scm")
(display (main-program))
(newline)
