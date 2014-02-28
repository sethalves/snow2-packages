#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/snowlib.sld")
(include "snow/bytevector.sld")
(include "snow/srfi-13-strings.sld")
(include "snow/srfi-60-integers-as-bits.sld")
(include "seth/string-read-write.sld")
(include "seth/quoted-printable.sld")
(include "seth/base64.sld")
(include "seth/mime.sld")
(include "seth/port-extras.sld")
(include "seth/http.sld")
(import (seth port-extras))
(import (seth http))

(include "test-common.scm")

(display (main-program))
(newline)
