#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

;; sudo chicken-install srfi-37

(use r7rs)
(import-for-syntax r7rs)

(import (scheme process-context))

(include "seth/srfi-37-argument-processor.sld")
(import (seth srfi-37-argument-processor))

(include "test-common.scm")
(main-program (command-line))
