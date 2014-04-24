#! /usr/bin/env chibi-scheme

(import (scheme base) (scheme write) (scheme read)
        (seth network-socket)
        (seth srfi-27-random)
        (seth port-extras))

(include "test-common.scm")

(display (main-program))
(newline)
