#!/usr/local/bin/foment

(import (scheme base)
        (scheme write)
        (seth model-3d tests))
(display (run-tests))
(newline)
