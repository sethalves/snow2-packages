#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow snowlib)
        (snow srfi-13-strings)
        (seth crypt md5)
        (seth http)
        (seth aws common)
        (seth aws s3))

(include "test-common.scm")

(display (main-program))
(newline)
