#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (snow bytevector)
        (seth sha-1))


(include "test-common.scm")

(display (main-program))
(newline)
