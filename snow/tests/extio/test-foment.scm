#! /usr/bin/env foment

(import (scheme base)
        (scheme file)
        (scheme write)
        (snow snowlib)
        (snow extio))


(include "test-common.scm")

(display (main-program))
(newline)
