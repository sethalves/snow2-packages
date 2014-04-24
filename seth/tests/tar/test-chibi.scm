#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (seth tar))


(include "test-common.scm")

(display (main-program))
(newline)
