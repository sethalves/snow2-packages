#! /usr/bin/env foment

(import (scheme base)
        (scheme write)
        (snow extio tests))
(display (run-tests))
(newline)
