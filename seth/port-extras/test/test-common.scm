
(define (main-program)
  ;; (flush-output-port (current-output-port))
  (and
   (let* ((str "ok hi blah blah")
          (sp (open-input-string str))
          (x (read-all-chars sp)))
     (equal? str x))

   (let* ((str "ok hi blah blah")
          (sp (open-input-string str))
          (words (read-words 3 sp)))
     (and (equal? (list-ref words 0) "ok")
          (equal? (list-ref words 1) "hi")
          (equal? (list-ref words 2) "blah"))))
  )