#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))
(include "srfi/60.sld")
(include "snow/bytevector.sld")
(include "seth/binary-pack.sld")
(include "seth/uuid.sld")
(include "seth/uuid/tests.sld")
(import (seth uuid tests))
(display (run-tests))
(newline)
