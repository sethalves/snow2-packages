#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

;; sudo chicken-install memcached

(use r7rs)
(import-for-syntax r7rs)

(use memcached)
(use base64)

(include "snow/bytevector.sld")
(include "snow/binio.sld")
(include "seth/string-read-write.sld")
(include "seth/base64.sld")
(include "seth/cout.sld")
(include "seth/network-socket.sld")
(include "seth/memcache-client.sld")
(include "seth/memcache-client/tests.sld")
(import (seth memcache-client tests))
(display (run-tests))
(newline)
