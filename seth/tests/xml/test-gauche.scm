#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(push! *load-suffixes* ".sld")' \
-e '(push! *load-path* ".")' \
-ftest -r7 $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow snowlib)
        (snow srfi-13-strings)
        (snow extio)
        (snow assert)
        (seth xml ssax)
        (seth xml sxpath))

(include "test-common.scm")

(display (main-program))
(newline)
