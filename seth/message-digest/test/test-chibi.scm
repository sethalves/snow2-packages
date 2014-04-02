#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme file)
        (scheme write)
        (snow bytevector)
        (seth message-digest primitive)
        (seth message-digest type)
        (seth message-digest bv)
        (seth message-digest port)
        (seth message-digest md5)
        (seth message-digest update-item)
        (seth message-digest item)
        )


(include "test-common.scm")

(display (main-program))
(newline)