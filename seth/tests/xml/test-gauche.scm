#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(push! *load-suffixes* ".sld")' \
-e '(push! *load-path* ".")' \
-ftest -r7 $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (srfi 13)
        (snow extio)
        (snow assert)
        (seth xml ssax)
        (seth xml sxpath))

(include "test-common.scm")

(display (main-program))
(newline)
