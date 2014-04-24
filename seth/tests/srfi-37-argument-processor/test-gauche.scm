#! /bin/sh
#| -*- scheme -*-
exec gosh \
-e '(push! *load-suffixes* ".sld")' \
-e '(push! *load-path* ".")' \
-ftest -r7 $0 "$@"
|#

(import (scheme base) (scheme write) (scheme process-context))
(import (seth srfi-37-argument-processor))
(include "test-common.scm")
(main-program (command-line))

