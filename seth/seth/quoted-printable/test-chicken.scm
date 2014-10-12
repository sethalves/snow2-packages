#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(import (scheme base))
(include "srfi/60.sld")
(include "seth/quoted-printable.sld")
(include "seth/quoted-printable/tests.sld")
(import (seth quoted-printable tests))
(display (run-tests))
(newline)
