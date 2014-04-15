#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (snow bytevector)
        (prefix (seth base64) base64-)
        (seth hmac)
        (seth crypt sha-1)
        (seth aws common)
        (seth aws s3))


(include "test-common.scm")

(display (main-program))
(newline)
