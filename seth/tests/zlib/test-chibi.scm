#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (scheme file)
        (snow genport)
        (seth port-extras)
        (seth zlib))

(include "test-common.scm")

(display (main-program))
(newline)
