#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (scheme process-context)
        (seth srfi-37-argument-processor))


(include "test-common.scm")
(main-program (command-line))
