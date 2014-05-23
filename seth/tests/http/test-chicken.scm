#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base)
        (scheme time)
        (scheme file))

(include "snow/bytevector.sld")
(include "snow/binio.sld")
(include "snow/extio.sld")
(include "seth/string-read-write.sld")
(include "seth/quoted-printable.sld")
(include "seth/base64.sld")
(include "seth/mime.sld")
(include "seth/port-extras.sld")
(include "seth/network-socket.sld")
(include "seth/uri.sld")
(include "seth/http.sld")
(import (snow binio))
(import (snow extio))
(import (seth port-extras))
(import (seth http))

(include "test-common.scm")

(display (main-program))
(newline)
