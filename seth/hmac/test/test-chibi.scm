#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (snow bytevector)
        (seth hmac))


(include "test-common.scm")

(display (main-program))
(newline)
