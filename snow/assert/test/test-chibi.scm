#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (snow snowlib)
        (snow assert))


(include "test-common.scm")

(display (main-program))
(newline)
