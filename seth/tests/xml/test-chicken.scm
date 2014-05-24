#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(import (scheme base))
(include "srfi/60.sld")
(include "snow/bytevector.sld")
(include "snow/extio.sld")
(include "snow/assert.sld")
(include "seth/xml/ssax.sld")
(include "seth/xml/sxpath.sld")
(include "seth/xml/sxml-serializer.sld")
(import (srfi 13))
(import (snow extio))
(import (snow assert))
(import (seth xml ssax))
(import (seth xml sxpath))
(import (seth xml sxml-serializer))

(include "test-common.scm")

(display (main-program))
(newline)
