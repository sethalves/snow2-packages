#!/usr/local/bin/foment

(import (scheme base)
        (scheme write)
        (snow bignum tests))
(display (run-tests))
(newline)
