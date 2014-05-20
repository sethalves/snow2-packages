#! /usr/bin/env foment

(import (scheme base)
        (scheme write)
        (snow srfi-19-time))


(include "test-common.scm")

(display (main-program))
(newline)
