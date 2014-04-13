#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme file)
        (scheme write)
        (snow bytevector)
        (seth md5))

(include "test-common.scm")

(display (main-program))
(newline)
