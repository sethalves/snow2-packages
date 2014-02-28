#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (snow input-parse))


(include "test-common.scm")

(display (main-program))
(newline)
