#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (snow bytevector)
        (seth uuid)
        (srfi 27)
        )

(include "test-common.scm")

(display (main-program))
(newline)
