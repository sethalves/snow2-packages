#!/usr/local/bin/foment

(import (scheme base)
        (scheme write)
        (seth strings tests))
(display (run-tests))
(newline)
