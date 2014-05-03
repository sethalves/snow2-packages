#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme time)
        (scheme read)
        (scheme file)
        (scheme write))
(import (snow binio)
        (snow extio)
        (seth port-extras)
        (seth http))

(include "test-common.scm")

(display (main-program))
(newline)
