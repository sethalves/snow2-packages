#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme file)
        (scheme write)
        (seth md5))

(include "test-common.scm")

(display (main-program))
(newline)
