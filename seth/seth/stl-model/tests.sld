(define-library (seth stl-model tests)
  (export run-tests)
  (import (scheme base)
          (scheme write)
          (seth stl-model))
  (begin
    (define (run-tests)
      (read-stl-model-file "test.stl")
      #t
      )))
