#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (seth mime))


(include "test-common.scm")

(display (main-program))
(newline)
