#! /usr/bin/env foment

(import (scheme base)
        (scheme cxr)
        (scheme write)
        (scheme char)
        (snow bytevector)
        (snow digest))
(include "test-common.scm")
(display (main-program))
(newline)
