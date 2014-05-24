#! /bin/sh
#| -*- scheme -*-
CHIBI_MODULE_PATH="" exec chibi-scheme -A . -s $0 "$@"
|#

(import (scheme base)
        (scheme write)
        (only (chibi) call-with-input-string)
        (srfi 13)
        (snow extio)
        (snow assert)
        (only (chibi string) string-null?)
        (srfi 1)
        (scheme char)
        (scheme cxr)
        (chibi io)
        (seth xml ssax)
        (seth xml sxpath)
        (seth xml sxml-serializer))
(include "test-common.scm")
(display (main-program))
(newline)
