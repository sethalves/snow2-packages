#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (scheme process-context)
        (snow snowlib)
        (snow filesys)
        (snow extio)
        (snow assert)
        (snow processio))

(include "test-common.scm")

(display (main-program))
(newline)
