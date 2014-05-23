#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "seth/tar.sld")
(include "seth/http.sld")
(include "seth/temporary-file.sld")
(include "seth/snow2-utils.sld")
(import (seth snow2-utils))

(include "test-common.scm")

(display (main-program))
(newline)
