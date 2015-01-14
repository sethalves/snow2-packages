(define-library (seth alexpander)
  (export alexpander-repl
          expand-program
          expand-top-level-forms!
          expand-top-level-forms)
  (import (scheme base)
          (scheme read)
          (scheme write)
          (scheme cxr)
          (rename (snow extio) (snow-pretty-print pretty-print)))
  (include "alexpander/alexpander.scm"))
