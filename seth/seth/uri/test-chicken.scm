#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base)
        (scheme write))
(include "seth/string-read-write.sld")
(include "seth/uri.sld")
(include "seth/uri/tests.sld")
(import (seth uri tests))
(display (run-tests))
(newline)
