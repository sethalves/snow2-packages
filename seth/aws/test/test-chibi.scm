#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (snow bytevector)
        (snow srfi-13-strings)
        (prefix (seth base64) base64-)
        (seth http)
        (seth crypt hmac-sha-1)
        (seth crypt sha-1)
        (seth aws common)
        (seth aws s3))


(include "test-common.scm")

(display (main-program))
(newline)
