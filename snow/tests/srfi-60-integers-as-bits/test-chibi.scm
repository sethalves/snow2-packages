#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (snow srfi-60-integers-as-bits))


(include "test-common.scm")

(display (main-program))
(newline)
