#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(use srfi-4)
(use openssl)
(use udp)
(include "seth/string-read-write.sld")
(include "snow/bytevector.sld")
(include "seth/port-extras.sld")
(include "seth/network-socket.sld")

(import (snow bytevector))
(import (seth network-socket))
(import (srfi 27))
(import (seth port-extras))

(include "test-common.scm")

(display (main-program))
(newline)
