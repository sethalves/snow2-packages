#! /usr/bin/env foment

(import (scheme base)
        (scheme write)
        (scheme char))
(import (snow srfi-13-strings))

(include "test-common.scm")

(display (main-program))
(newline)

