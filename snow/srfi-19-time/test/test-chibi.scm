#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (snow srfi-19-time))


(include "test-common.scm")

(display (main-program))
(newline)
