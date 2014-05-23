#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(use r7rs)
(import-for-syntax r7rs)
(import (scheme base)
        (scheme write))

(include "snow/bytevector.sld")
(include "seth/gensym.sld")
(include "seth/variable-item.sld")
(include "seth/message-digest/parameters.sld")
(include "seth/message-digest/primitive.sld")
(include "seth/message-digest/type.sld")
(include "seth/message-digest/support.sld")
(include "seth/message-digest/bv.sld")
(include "seth/message-digest/port.sld")
(include "seth/message-digest/update-item.sld")
(include "seth/message-digest/item.sld")
(include "seth/message-digest/md5.sld")

(import (snow bytevector)
        (seth message-digest primitive)
        (seth message-digest type)
        (seth message-digest bv)
        (seth message-digest port)
        (seth message-digest md5)
        (seth message-digest update-item)
        (seth message-digest item))

(include "test-common.scm")

(display (main-program))
(newline)
