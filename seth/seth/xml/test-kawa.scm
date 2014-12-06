#! /bin/sh
#| -*- scheme -*-
exec /usr/local/bin/kawa \
  -Dkawa.import.path="./*.sld" \
  -Dkawa.include.path='|:.' \
  --r7rs \
  $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (seth xml tests)
        )
(display (trace (run-tests)))
(newline)
