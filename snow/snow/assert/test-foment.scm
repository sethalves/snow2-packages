#!/usr/local/bin/foment

(import (scheme base)
        (scheme write)
        (snow assert tests))
(display (run-tests))
(newline)
