#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (snow bytevector)
        (prefix (seth binary-pack) binary:))

(include "test-common.scm")

(display (main-program))
(newline)
