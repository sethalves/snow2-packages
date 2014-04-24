#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (seth temporary-file))


(include "test-common.scm")

(display (main-program))
(newline)
