#! /bin/sh
#| -*- scheme -*-
exec sash -A . -F .sld $0 "$@"
|#

(import (scheme base) (scheme write))
(import (prefix (seth base64) base64:))
(include "test-common.scm")
(display (main-program))
(newline)
