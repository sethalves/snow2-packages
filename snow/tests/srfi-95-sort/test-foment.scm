#! /usr/bin/env foment

(import (scheme base)
        (scheme write)
        (scheme char)
        (snow srfi-95-sort))


(include "test-common.scm")

(display (main-program))
(newline)
