#! /bin/sh
#| -*- scheme -*-
exec /usr/local/bin/kawa \
  -Dkawa.import.path="./*.sld" \
  -Dkawa.include.path='|:.' \
  $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (seth math-3d tests))
(display (run-tests))
(newline)
