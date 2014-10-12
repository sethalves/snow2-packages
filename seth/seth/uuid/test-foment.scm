#!/usr/local/bin/foment

(import (scheme base)
        (scheme write)
        (seth uuid tests))
(display (run-tests))
(newline)
