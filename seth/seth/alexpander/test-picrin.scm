#! /usr/bin/env picrin

(import (scheme base)
        (scheme write)
        (seth alexpander tests))
(display (run-tests))
(newline)
