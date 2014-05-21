#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))


(include "snow/srfi-1-lists.sld")
(include "snow/bytevector.sld")
(include "snow/srfi-13-strings.sld")
(include "snow/srfi-19-time.sld")
(include "snow/srfi-29-format.sld")
(include "snow/srfi-60-integers-as-bits.sld")
(include "snow/binio.sld")
(include "snow/extio.sld")
(include "snow/srfi-95-sort.sld")
(include "seth/string-read-write.sld")
(include "seth/port-extras.sld")
(include "seth/network-socket.sld")
(include "seth/uri.sld")
(include "seth/xml/ssax.sld")
(include "seth/xml/sxpath.sld")
(include "seth/crypt/md5.sld")
(include "seth/crypt/hmac-sha-1.sld")
(include "seth/quoted-printable.sld")
(include "seth/base64.sld")
(include "seth/mime.sld")
(include "seth/http.sld")
(include "seth/aws/common.sld")
(include "seth/aws/s3.sld")
(import (snow srfi-13-strings)
        (only (seth http) log-http-to-stderr)
        (seth crypt md5)
        (seth aws common)
        (seth aws s3))

(include "test-common.scm")

(display (main-program))
(newline)
