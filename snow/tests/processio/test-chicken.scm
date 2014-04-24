#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme process-context))

(include "snow/snowlib.sld")
(import (snow snowlib))

(include "snow/bytevector.sld")
(import (snow bytevector))

(include "snow/srfi-13-strings.sld")
(import (snow srfi-13-strings))

(include "snow/bignum.sld")
(import (snow bignum))

(include "snow/binio.sld")
(import (snow binio))

(include "snow/random.sld")
(import (snow random))

(include "snow/filesys.sld")
(import (snow filesys))

(include "snow/assert.sld")
(import (snow assert))

(include "snow/extio.sld")
(import (snow extio))

(include "snow/processio.sld")
(import (snow processio))

(include "test-common.scm")

(display (main-program))
(newline)
