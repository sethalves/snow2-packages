#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme char)
        (scheme write)
        (snow srfi-14-character-sets))


(include "test-common.scm")

(display (main-program))
(newline)
