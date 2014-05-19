#! /usr/bin/env foment

(import (scheme base)
        (scheme write)
        (scheme char)
        (snow srfi-13-strings)
        (snow srfi-14-character-sets)
        )

(include "test-common.scm")

(display (main-program))
(newline)

