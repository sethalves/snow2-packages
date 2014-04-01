#! /bin/sh
#| -*- scheme -*-
exec sash -L . -S .sld $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (seth message-digest primitive)
        (seth message-digest type)
        )


(include "test-common.scm")

(display (main-program))
(newline)
