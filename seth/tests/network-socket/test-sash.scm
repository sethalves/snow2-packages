#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#
(import (scheme base) (scheme write) (scheme read)
        (seth network-socket)
        (srfi 27)
        (seth port-extras))
(include "test-common.scm")
(display (main-program))
(newline)
