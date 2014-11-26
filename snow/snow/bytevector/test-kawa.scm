#! /bin/sh
#| -*- scheme -*-
exec /usr/local/bin/kawa \
  -Dkawa.import.path="./*.sld" \
  $0 "$@"
|#

(import (scheme base))
(import (scheme write))
(import (snow bytevector tests))
(display (run-tests))
(newline)
