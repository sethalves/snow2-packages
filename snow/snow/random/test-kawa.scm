#! /bin/sh
#| -*- scheme -*-
exec /usr/local/bin/kawa \
  -Dkawa.import.path="./*.sld" \
  $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (snow random tests))
(display (run-tests))
(newline)
