#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (snow bytevector)
        (seth crypt sha-1)
        (seth crypt md5)
        (seth crypt hmac))
(include "test-common.scm")
(display (main-program))
(newline)
