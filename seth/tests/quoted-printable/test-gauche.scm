#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(push! *load-suffixes* ".sld")' \
-e '(push! *load-path* ".")' \
-ftest -r7 $0 "$@"
|#

(import (scheme base) (scheme write))
(import (seth quoted-printable))
(include "test-common.scm")
(display (main-program))
(newline)
