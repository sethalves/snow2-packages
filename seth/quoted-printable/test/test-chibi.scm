#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (seth quoted-printable))


(include "test-common.scm")

(display (main-program))
(newline)
