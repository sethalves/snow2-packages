#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)

(import (scheme base))
(include "srfi/26.sld")
(include "srfi/60.sld")
(include "snow/bytevector.sld")
(include "snow/assert.sld")
(include "snow/extio.sld")
(include "snow/binio.sld")
(include "snow/digest.sld")
(include "snow/genport.sld")
(include "snow/zlib.sld")
(include "weinholt/r6rs-compatibility.sld")
(include "weinholt/bytevectors.sld")
(include "weinholt/struct/der.sld")
(include "weinholt/struct/pack-aux.sld")
(include "weinholt/struct/pack.sld")
(include "seth/minecraft-nbt.sld")
(include "seth/minecraft-nbt/tests.sld")
(import (seth minecraft-nbt tests))
(display (run-tests))
(newline)
