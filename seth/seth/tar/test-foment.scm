#!/usr/local/bin/foment

(import (scheme base)
        (scheme write)
        (seth tar tests))
(display (run-tests))
(newline)
