#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(import (scheme base))
(import (scheme process-context))
(include "snow/srfi-1-lists.sld")
(include "snow/srfi-60-integers-as-bits.sld")
(include "snow/bytevector.sld")
(import (snow bytevector))
(include "snow/srfi-13-strings.sld")
(import (snow srfi-13-strings))
(include "snow/filesys.sld")
(import (snow filesys))
(include "snow/extio.sld")
(import (snow extio))
(include "snow/processio.sld")
(import (snow processio))
(include "test-common.scm")
(display (main-program))
(newline)
