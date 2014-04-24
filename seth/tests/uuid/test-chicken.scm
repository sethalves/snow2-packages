#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(use srfi-4)

(include "snow/bytevector.sld")
(include "snow/srfi-60-integers-as-bits.sld")
(include "snow/srfi-13-strings.sld")
(include "seth/srfi-27-random.sld")
(include "seth/binary-pack.sld")
(include "seth/uuid.sld")
(import (seth uuid) (seth srfi-27-random))

(include "test-common.scm")

(display (main-program))
(newline)
