#!/usr/local/bin/foment

(import (scheme base)
        (scheme write)
        (seth obj-model tests))
(display (run-tests))
(newline)
