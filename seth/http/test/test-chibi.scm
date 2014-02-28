#! /usr/bin/env chibi-scheme

(import (scheme base) (scheme file) (scheme write))
(import (seth port-extras) (seth http))

(include "test-common.scm")

(display (main-program))
(newline)
