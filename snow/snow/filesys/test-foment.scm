#! /usr/bin/env foment

(import (scheme base)
        (scheme write)
        (snow filesys tests))
(display (run-tests))
(newline)
