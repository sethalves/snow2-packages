#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "seth/srfi-69-hash-tables.sld")
(import (seth srfi-69-hash-tables))

(include "test-common.scm")

(display (main-program))
(newline)
