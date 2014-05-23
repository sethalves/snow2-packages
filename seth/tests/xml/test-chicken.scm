#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/bytevector.sld")
(include "seth/xml/ssax.sld")
(include "seth/xml/sxpath.sld")
(include "snow/extio.sld")
(include "snow/assert.sld")
(import (srfi 13))
(import (snow extio))
(import (snow assert))
(import (seth xml ssax))
(import (seth xml sxpath))

(include "test-common.scm")

(display (main-program))
(newline)
