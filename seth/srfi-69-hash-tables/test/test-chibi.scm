#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (seth srfi-69-hash-tables))


(include "test-common.scm")

(display (main-program))
(newline)