#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (scheme process-context)
        (seth srfi-37-argument-processor))


(include "test-common.scm")
(main-program (command-line))
