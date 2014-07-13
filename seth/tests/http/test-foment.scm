#! /bin/sh
#| -*- scheme -*-
exec foment $0 "$@"
|#

(import (scheme base)
        (scheme read)
        (scheme write)
        (scheme file)
        (scheme time))
(import (snow binio)
        (snow extio)
        (seth port-extras)
        (seth http))
(include "test-common.scm")
(display (main-program))
(newline)
