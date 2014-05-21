#! /usr/bin/env foment

(import (scheme base)
        (scheme file)
        (scheme write)
        (snow extio))
(include "test-common.scm")
(display (main-program))
(newline)
