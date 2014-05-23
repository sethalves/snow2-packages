#! /usr/bin/env chibi-scheme

(import (scheme base) (scheme write) (scheme read)
        (seth network-socket)
        (srfi 27)
        (seth port-extras))

(include "test-common.scm")

(display (main-program))
(newline)
