#! /usr/bin/env picrin

(import (scheme base)
        (scheme write)
        (seth cout tests))
(display (run-tests))
(newline)
