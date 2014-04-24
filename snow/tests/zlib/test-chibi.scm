#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (snow binio)
        (snow genport)
        (snow zlib))


(include "test-common.scm")

(display (main-program))
(newline)
