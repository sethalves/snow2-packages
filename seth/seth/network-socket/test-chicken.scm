#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(use openssl)
(use udp)
(import (scheme base))
(include "snow/bytevector.sld")
(include "seth/port-extras.sld")
(include "seth/network-socket.sld")
(include "seth/network-socket/tests.sld")
(import (seth network-socket tests))
(display (run-tests))
(newline)
