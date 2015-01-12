#! /bin/sh
#| -*- scheme -*-
exec foment $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (seth minecraft-nbt tests))
(display (run-tests))
(newline)
