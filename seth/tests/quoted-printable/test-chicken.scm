#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "seth/quoted-printable.sld")
(import (seth quoted-printable))

(include "test-common.scm")

(display (main-program))
(newline)
