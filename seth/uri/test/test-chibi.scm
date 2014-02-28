#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (srfi 1)
        (seth uri))


(include "test-common.scm")

(display (main-program))
(newline)
