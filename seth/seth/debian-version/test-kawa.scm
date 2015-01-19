#! /bin/sh
#| -*- scheme -*-
exec /usr/local/bin/kawa \
  -Dkawa.import.path="./*.sld" \
  -Dkawa.include.path='|:.' \
  $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (seth debian-version tests))
(display (run-tests))
(newline)
