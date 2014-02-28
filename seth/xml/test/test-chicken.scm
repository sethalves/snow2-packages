#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(include "snow/snowlib.sld")
(include "seth/xml/ssax.sld")
(include "seth/xml/sxpath.sld")
(include "snow/srfi-13-strings.sld")
(include "snow/extio.sld")
(include "snow/assert.sld")
(import (snow snowlib))
(import (snow srfi-13-strings))
(import (snow extio))
(import (snow assert))
(import (seth xml ssax))
(import (seth xml sxpath))

(include "test-common.scm")

(display (main-program))
(newline)
