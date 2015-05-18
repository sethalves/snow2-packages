#!/usr/local/bin/foment

(import (scheme base)
        (scheme write)
        (seth stl-model tests))
(display (run-tests))
(newline)
