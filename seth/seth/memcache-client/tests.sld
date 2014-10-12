(define-library (seth memcache-client tests)
  (export run-tests)
  (import (scheme base)
          (seth cout)
          (seth memcache-client))
  (begin
    (define (run-tests)


      (define mcc (connect "localhost" 11211))
      (define (buhbuhbuh)
        (update-entry! mcc "buhbuhbuh" 0 0
                       (lambda (previous-value)
                         (cond ((eq? previous-value #f) 0)
                               (else
                                (+ previous-value 1))))))

      (set-entry! mcc "test-key" 0 0 "test-value")
      (set-entry! mcc "test-key1" 0 0 "test-value1")
      (cout (get-entry mcc "test-key") "\n")
      (cout (get-entries mcc '("test-key" "test-key1")) "\n")

      (cout (get-entry mcc "buhbuhbuh") "\n")
      (buhbuhbuh)
      (cout (get-entry mcc "buhbuhbuh") "\n")
      (buhbuhbuh)
      (cout (get-entry mcc "buhbuhbuh") "\n")

      (delete-entry! mcc "buhbuhbuh")

      (cout (get-entry mcc "buhbuhbuh") "\n")

      (set-entry! mcc "counter" 0 0 101)
      (incr! mcc "counter" 2)
      (cout (get-entry mcc "counter") "\n")
      (decr! mcc "counter" 2)
      (cout (get-entry mcc "counter") "\n")

      (for-each
       (lambda (stat)
         (cout "  :" stat "\n"))
       (stats mcc))

      (disconnect mcc)
      #t)))
