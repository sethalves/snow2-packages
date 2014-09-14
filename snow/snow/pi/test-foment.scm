#! /bin/sh
#| -*- scheme -*-
exec foment -A ../.. $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow pi))
(include "test-common.scm")
(display (main-program))
(newline)
