#! /usr/bin/env foment

(import (scheme base)
        (scheme write)
        (snow digest tests))
(display (run-tests))
(newline)
