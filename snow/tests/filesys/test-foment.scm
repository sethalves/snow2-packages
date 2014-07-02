#! /usr/bin/env foment

(import (scheme base)
        (scheme file)
        (scheme write)
        (srfi 1)
        (snow filesys))


(include "test-common.scm")

(display (main-program))
(newline)
