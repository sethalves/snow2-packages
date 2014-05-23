#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(import (scheme base))
(include "srfi/60.sld")
(import (scheme process-context))
(include "snow/bytevector.sld")
(import (snow bytevector))
(import (srfi 13))
(include "snow/filesys.sld")
(import (snow filesys))
(include "snow/extio.sld")
(import (snow extio))
(include "snow/processio.sld")
(import (snow processio))
(include "test-common.scm")
(display (main-program))
(newline)
