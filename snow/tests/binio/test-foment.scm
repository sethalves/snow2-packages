#! /usr/bin/env foment

(import (scheme base)
        (scheme write)
        (snow binio))
(include "test-common.scm")
(display (main-program))
(newline)