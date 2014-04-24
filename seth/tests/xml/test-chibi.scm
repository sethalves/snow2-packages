#! /usr/bin/env chibi-scheme

(import (scheme base)
        (scheme write)
        (snow snowlib)
        (only (chibi) call-with-input-string)
        (snow srfi-13-strings)
        (snow extio)
        (snow assert)
        (only (chibi string) string-null?)
        (srfi 1)
        (scheme char)
        (scheme cxr)
        (chibi io)
        (seth xml ssax)
        (seth xml sxpath))

(include "test-common.scm")

(display (main-program))
(newline)
