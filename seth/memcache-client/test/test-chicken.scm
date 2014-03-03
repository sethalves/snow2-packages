#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(use memcached)
(use base64)

(include "snow/srfi-13-strings.sld")
(include "snow/bytevector.sld")
(include "seth/string-read-write.sld")
(include "seth/port-extras.sld")
(include "seth/base64.sld")
(include "seth/cout.sld")
(include "seth/network-socket.sld")
(include "seth/memcache-client.sld")

(import (seth memcache-client) (seth cout))

(include "test-common.scm")

(display (main-program))
(newline)
