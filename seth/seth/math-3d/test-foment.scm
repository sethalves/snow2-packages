#!/usr/local/bin/foment

(import (scheme base)
        (scheme write)
        (seth math-3d tests))
(display (run-tests))
(newline)
