#! /usr/bin/env chibi-scheme

(import (scheme base) (scheme write) (scheme char))
(import (chibi char-set) (chibi char-set full))
(import (snow srfi-13-strings))

(include "test-common.scm")

(display (main-program))
(newline)

