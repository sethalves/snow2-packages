#! /usr/bin/env foment

(import (scheme base)
        (scheme write)
        (snow binio tests))
(display (run-tests))
(newline)
