#!/usr/local/bin/foment

(import (scheme base)
        (scheme write)
        (seth port-extras tests))
(display (run-tests))
(newline)
