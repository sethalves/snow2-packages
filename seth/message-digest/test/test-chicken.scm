#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base))

(include "snow/snowlib.sld")
(include "snow/bytevector.sld")
(include "seth/gensym.sld")
(include "seth/string-read-write.sld")
(include "seth/srfi-69-hash-tables.sld")
(include "seth/message-digest/primitive.sld")
(include "seth/message-digest/type.sld")
(include "seth/message-digest/support.sld")
(include "seth/message-digest/bv.sld")
(include "seth/message-digest/port.sld")
(import (seth message-digest primitive)
        (seth message-digest type)
        (seth message-digest bv)
        (seth message-digest port))

(include "test-common.scm")

(display (main-program))
(newline)
