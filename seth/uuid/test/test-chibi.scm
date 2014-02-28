#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (snow bytevector)
        (seth uuid)
        (seth srfi-27-random)
        )

(include "test-common.scm")

(display (main-program))
(newline)
