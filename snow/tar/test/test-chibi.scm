#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (snow tar))


(include "test-common.scm")

(display (main-program))
(newline)
