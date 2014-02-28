#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(use srfi-4)

(include "snow/bytevector.sld")
(include "seth/binary-pack.sld")
(import (snow bytevector))
(import (prefix (seth binary-pack) binary:))

(include "test-common.scm")

(display (main-program))
(newline)
