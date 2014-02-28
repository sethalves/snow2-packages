;; -*- scheme -*-

(define-module snow.gauche-extio-utils
  (export snow-force-output)
  ;; (use gauche.net)

  (define (snow-force-output . maybe-port)
    (let ((port (if (null? maybe-port) (current-output-port)
                    (car maybe-port))))
      (flush port))))
