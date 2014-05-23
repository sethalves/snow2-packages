#! /bin/sh
#| -*- scheme -*-
exec sash -A . -S .sld $0 "$@"
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
