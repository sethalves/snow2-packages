#! /bin/sh
#| -*- scheme -*-
CHIBI_MODULE_PATH="$CHIBI_MODULE_PATH" exec chibi-scheme -A /usr/local/share/scheme -A . -s $0 "$@"
|#


(import (scheme base)
        (scheme write)
        (snow bytevector)
        (srfi 13)
        (prefix (seth base64) base64-)
        (seth http)
        (seth crypt md5)
        (seth aws common)
        (seth aws s3))


(include "test-common.scm")

(display (main-program))
(newline)
