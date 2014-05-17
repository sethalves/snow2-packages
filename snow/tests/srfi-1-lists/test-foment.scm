#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (snow srfi-1-lists))

(include "test-common.scm")

(display (main-program))
(newline)
