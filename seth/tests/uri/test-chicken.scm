#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/srfi-29-format.sld")
(include "snow/srfi-13-strings.sld")
(include "seth/string-read-write.sld")
(include "seth/uri.sld")
(import (scheme base)
        (snow srfi-29-format))
(import (seth uri))

(include "test-common.scm")

(display (main-program))
(newline)
