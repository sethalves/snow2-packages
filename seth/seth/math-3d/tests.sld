(define-library (seth math-3d tests)
  (export run-tests)
  (import (scheme base)
          (scheme write)
          (scheme inexact)
          (srfi 1)
          (seth math-3d)
          (seth cout)
          )
  (begin
    (define (run-tests)


      (define (test-vector-rotations x-rot y-rot z-rot vec-to-rotate e->q)
        (let* ((eu (vector x-rot y-rot z-rot))
               (q-from-eu (e->q eu))

               (q-xrot (rotation-quaternion (vector 1 0 0) x-rot))
               (q-yrot (rotation-quaternion (vector 0 1 0) y-rot))
               (q-zrot (rotation-quaternion (vector 0 0 1) z-rot))
               (q-rot (combine-rotations q-zrot q-yrot q-xrot))

               (m-from-q-from-eu (quaternion->matrix q-from-eu))
               (m-from-q-rot (quaternion->matrix q-rot))

               (m-xrot (matrix-rotation-x x-rot))
               (m-yrot (matrix-rotation-y y-rot))
               (m-zrot (matrix-rotation-z z-rot))
               (m-rot (matrix-* m-xrot m-yrot m-zrot))
               ;;
               (res0 (vector3-rotate vec-to-rotate q-from-eu))
               (res1 (vector3-rotate vec-to-rotate q-rot))
               (res2 (vector4->3 (matrix-* m-from-q-from-eu
                                           (vector3->4 vec-to-rotate))))
               (res3 (vector4->3 (matrix-* m-from-q-rot
                                           (vector3->4 vec-to-rotate))))
               (res4 (vector4->3 (matrix-* m-rot (vector3->4 vec-to-rotate))))
               )

          (cond ((not (vector3-equal? res0 res1))
                 (cout "res1 mismatch- " (matrix->string res1) "\n"))
                ((not (vector3-equal? res0 res2))
                 (cout "res2 mismatch- " (matrix->string res2) "\n"))
                ((not (vector3-equal? res0 res3))
                 (cout "res3 mismatch- " (matrix->string res3) "\n"))
                ((not (vector3-equal? res0 res4))
                 (cout "res4 mismatch- " (matrix->string res4) "\n")))))



      (define (test-rotation-set tester)
        (let ((result #t))
          (do ((x-rot -90 (+ x-rot 60)))
              ((>= x-rot 360) #t)
            (do ((y-rot -90 (+ y-rot 60)))
                ((>= y-rot 450) #t)
              (do ((z-rot 0 (+ z-rot 60)))
                  ((>= z-rot 450) #t)
                (if (not (tester (vector (degrees->radians x-rot)
                                         (degrees->radians y-rot)
                                         (degrees->radians z-rot))))
                    (set! result #f)))))
          result))


      (define (test-vector-rotation-sets e->q)
          (do ((x -2 (+ x 0.5)))
              ((> x 2) #t)
            (do ((y -2 (+ y 0.5)))
                ((> y 2) #t)
              (do ((z -2 (+ z 0.5)))
                  ((> z 2) #t)
                (let ((tester (lambda (rot)
                                (test-vector-rotations
                                 (vector3-x rot)
                                 (vector3-y rot)
                                 (vector3-z rot)
                                 (vector x y z)
                                 e->q))))
                  (cout "testing " (vector x y z) "\n")
                  (test-rotation-set tester))))))


      (define (test-distance-from-point-to-plane)
        ;; (cout (distance-from-point-to-plane
        ;;        (vector 1 1 1)
        ;;        (vector (vector 0 0 0) (vector 0 0 1)))
        ;;       "\n")
        (and
         (eqv? (distance-from-point-to-plane (vector 1.0 1.0 1.0)
                                             (vector (vector 0 0 0) (vector 0 0 1)))
               1.0)
         (eqv? (distance-from-point-to-plane (vector 1.0 3.0 1.0)
                                             (vector (vector 0 0 -1) (vector 0 0 1)))
               2.0)
         (eqv? (distance-from-point-to-plane (vector 1.0 1.0 1.0)
                                             (vector (vector 0 0 0) (vector 0 1 0)))
               1.0)
         (eqv? (distance-from-point-to-plane (vector 1.0 1.0 1.0)
                                             (vector (vector 0 0 0) (vector 1 0 0)))
               1.0)
         (eqv? (distance-from-point-to-plane (vector 1.0 1.0 1.0)
                                             (vector (vector 0 0 0) (vector -1 0 0)))
               1.0)))


      (define (test-segment-plane-intersection)
        (and
         (eq? (segment-plane-intersection (vector (vector 5.0 5.0 5.0)
                                                  (vector 5.0 5.0 10.0))
                                          (vector (vector 0.0 0.0 0.0)
                                                  (vector 0.0 0.0 1.0)))
              #f)
         (equal? (segment-plane-intersection (vector (vector 5.0 5.0 5.0)
                                                     (vector 5.0 5.0 -10.0))
                                             (vector (vector 0.0 0.0 0.0)
                                                     (vector 0.0 0.0 1.0)))
                 (vector 5.0 5.0 0.0))))


      (define (test-quatenion-and-euler e->q q->e euler-rotation)
        (let* ((q (e->q euler-rotation))
               (e (q->e q))
               (q~ (e->q e)))
          (cond ((< (min (vector-magnitude (vector-diff q q~)) (vector-magnitude (vector-diff q (vector-scale q~ -1.0))))
                    epsilon)
                 #t)
                (else
                 (cout "mismatch -- " euler-rotation " : "
                       (vector-magnitude (vector-diff q q~)) " "
                       (vector-magnitude (vector-diff q (vector-scale q~ -1.0))) "\n")
                 #f))))


      (define (test-point-above-plane)
        (and
         (point-is-above-plane
          (vector 1.0 1.0 1.0)
          (vector (vector 0.0 0.0 0.0) (vector 0.0 1.0 0.0)))
         (not (point-is-above-plane
               (vector 1.0 -1.0 1.0)
               (vector (vector 0.0 0.0 0.0) (vector 0.0 1.0 0.0))))
         ))

      ;; (begin (display (number->pretty-string 100.0 4)) (newline))
      ;; (begin (display (number->pretty-string 100.1 4)) (newline))


      (define (test-sphere-aa-box-intersection)
        (and
         (not (sphere-intersects-aa-box? (make-sphere (vector 1.0 0.0 0.0) 0.5)
                                         (make-aa-box (vector 0.0 -1.0 -1.0)
                                                      (vector 0.4 1.0 1.0))))
         (sphere-intersects-aa-box? (make-sphere (vector 1.0 0.0 0.0) 0.5)
                                    (make-aa-box (vector 0.0 -1.0 -1.0)
                                                 (vector 0.55 1.0 1.0)))
         (not (sphere-intersects-aa-box? (make-sphere (vector -1.0 0.0 0.0) 0.9)
                                         (make-aa-box (vector 0.0 -1.0 -1.0)
                                                      (vector 0.4 1.0 1.0))))
         (sphere-intersects-aa-box? (make-sphere (vector -1.0 0.0 0.0) 1.1)
                                    (make-aa-box (vector 0.0 -1.0 -1.0)
                                                 (vector 0.55 1.0 1.0)))))


      (and  (= (+f 2 4) 6)
            (eq? (+f #f 4) #f)
            (eq? (+f 4 #f) #f)
            (eq? (+f #f #f) #f)
            (eq? (+f #f #f 1 5) #f)
            (eq? (+f #f 3 1 5) #f)
            (= (+f 1 3 1 5) 4)
            (= (+f 2 3 1 5) 5)
            (= (+f 3 3 1 5) 5)
            (= (+f 3.1 3 1 5) 5)
            (= (+f 3 3 1 #f) 6)
            (= (+f 3 3 #f 5) 5)
            (= (+f 3 3 #f) 6)
            (= (+f 3 3 1) 6)
            (= (+f 3 3 7) 7)
            (equal? (parse-vector "<1,2,3>") (vector '1 '2 '3))
            (equal? (parse-vector " <1,2,3>") (vector '1 '2 '3))
            (equal? (parse-vector "< 1,2,3>") (vector '1 '2 '3))
            (equal? (parse-vector "<1 ,2,3>") (vector '1 '2 '3))
            (equal? (parse-vector "<1, 2,3>") (vector '1 '2 '3))
            (equal? (parse-vector "<1,2 ,3>") (vector '1 '2 '3))
            (equal? (parse-vector "<1,2, 3>") (vector '1 '2 '3))
            (equal? (parse-vector "<1,2,3 >") (vector '1 '2 '3))
            (equal? (parse-vector "<1,2,3> ") (vector '1 '2 '3))
            (equal? (parse-vector "<-1,2,3>") (vector '-1 '2 '3))
            (equal? (parse-vector "<1,-2,3>") (vector '1 '-2 '3))
            (equal? (parse-vector "<1,2,-3>") (vector '1 '2 '-3))
            (equal? (parse-vector " <1,2,3>") (vector '1 '2 '3))
            (equal? (parse-vector "< 1,2,3>") (vector '1 '2 '3))
            (equal? (parse-vector "<-1 ,2,3>") (vector '-1 '2 '3))
            (equal? (parse-vector "<1 ,-2,3>") (vector '1 '-2 '3))
            (equal? (parse-vector "<1 ,2,-3>") (vector '1 '2 '-3))
            (equal? (parse-vector "<-1, 2,3>") (vector '-1 '2 '3))
            (equal? (parse-vector "<1, -2,3>") (vector '1 '-2 '3))
            (equal? (parse-vector "<1, 2,-3>") (vector '1 '2 '-3))
            (equal? (parse-vector "<-1,2 ,3>") (vector '-1 '2 '3))
            (equal? (parse-vector "<1,-2 ,3>") (vector '1 '-2 '3))
            (equal? (parse-vector "<1,2 ,-3>") (vector '1 '2 '-3))
            (equal? (parse-vector "<-1,2, 3>") (vector '-1 '2 '3))
            (equal? (parse-vector "<1,-2, 3>") (vector '1 '-2 '3))
            (equal? (parse-vector "<1,2, -3>") (vector '1 '2 '-3))
            (equal? (parse-vector "<-1,2,3 >") (vector '-1 '2 '3))
            (equal? (parse-vector "<1,-2,3 >") (vector '1 '-2 '3))
            (equal? (parse-vector "<1,2,-3 >") (vector '1 '2 '-3))
            (equal? (parse-vector "<-1,2,3> ") (vector '-1 '2 '3))
            (equal? (parse-vector "<1,-2,3> ") (vector '1 '-2 '3))
            (equal? (parse-vector "<1,2,-3> ") (vector '1 '2 '-3))
            (equal? (parse-vector "<1.5,2,-3> ") (vector '1.5 '2 '-3))
            (equal? (parse-vector "<1.5,2,-3.5 > ") (vector '1.5 '2 '-3.5))

            ;; scsh doesn't like this one.
            ;; (equal? (parse-vector "<1e2,2,-3.5 > ") (vector '100.0 '2 '-3.5))

            (equal? (parse-vector "<1,2,,3> ") #f)
            (equal? (parse-vector "<1,,3> ") #f)
            (equal? (parse-vector-full " <1, 2, 3> ")
                    (list (vector '1 '2 '3) (list 'success 10)))
            (equal? (parse-vector-full "<1,,3> ")
                    (list #f (list 'non-number 6 "1" "" "3")))

            (let loop ((a 0.0))
              (if (> a (* 2 pi)) #t
                  (let ((x (cos a))
                        (y (sin a)))
                    ;; (cout "x=" x " y=" y " a=" a "\n")
                    ;; (cout " atan=" (atan2 y x) "\n")
                    (if (almost= (atan2 y x) a 0.0001)
                        (loop (+ a (degrees->radians 1.)))
                        #f))))

            ;; (every
            ;;  (lambda (eu)
            ;;    (let* ((eu0 (degrees->radians eu))
            ;;           (q0 (euler->quaternion eu0))
            ;;           (eu1 (quaternion->euler q0))
            ;;           (q1 (euler->quaternion eu1)))

            ;;      ;; (cout "\n")
            ;;      ;; (cout (pv (euler->quaternion eu0)) "\n")
            ;;      ;; (cout (pv (euler->quaternion-1 eu0)) "\n")
            ;;      ;; (cout (pv (radians->degrees eu0)) "\n")
            ;;      ;; (cout (pv (radians->degrees eu1)) "\n")
            ;;      ;; (cout (pv q0) "\n" (pv q1) "\n")
            ;;      (vector3-equal? q0 q1)))
            ;;  (list (vector 270 0 0)
            ;;        (vector 0 90 0)
            ;;        (vector 0 -90 8)
            ;;        (vector 0 0 90)
            ;;        (vector 90 90 90)
            ;;        (vector 180 0 90)))

            (= (matrix-determinant (vector (vector 1 2 0)
                                           (vector -1 1 1)
                                           (vector 1 2 3)))
               9)

            (= (matrix-determinant (vector (vector 1 2 8 10 )
                                           (vector 3 4 -1 5)
                                           (vector 8 2 1 0)
                                           (vector 0 1 3 0)))
               995)

            (let ((a (vector (vector 1 3 4)
                             (vector 2 0 1)))
                  (b (vector (vector 1 2 3 1)
                             (vector 2 2 2 2)
                             (vector 3 2 1 4))))
              (equal? (matrix-* a b)
                      (vector (vector 19 16 13 23)
                              (vector 5 6 7 6))))


            (let ((p1 (vector 5 5 0))
                  (p2 (vector 0 0 0))
                  (p3 (vector 10 2 0)))
              ;; http://ca.geocities.com/web_sketches/circle_calculators/CIRCLE_POINTS.html
              (equal? (circle-center-from-circumference-points-2d p1 p2 p3)
                      (vector 5.25 -0.25)))


            (let* ((p1 (vector 5 5 1))
                   (p2 (vector -20 40 1))
                   (p3 (vector 10 2 23))
                   (c (circle-center-from-circumference-points p1 p2 p3)))

              ;; (cout (distance-between-points p1 c) " "
              ;;       (distance-between-points p2 c) " "
              ;;       (distance-between-points p3 c) "\n")

              (and (almost= (distance-between-points p1 c)
                            (distance-between-points p2 c) 0.0000001)
                   (almost= (distance-between-points p1 c)
                            (distance-between-points p3 c) 0.0000001)))


            (test-distance-from-point-to-plane)
            (test-segment-plane-intersection)

            (= (clamp-number -1 2 3) 2)
            (= (clamp-number 2 2 3) 2)
            (= (clamp-number 3 2 3) 3)
            (= (clamp-number 4 2 3) 3)
            (= (clamp-number -1 2 2) 2)
            (= (clamp-number 2 2 2) 2)
            (= (clamp-number 3 2 2) 2)

            (let* ((axis (vector 1. 0. 0.))
                   (q (rotation-quaternion axis (degrees->radians 90)))
                   (v0 (vector 1. 2. 3.))
                   (v1 (vector 4. 4. 4.))
                   (v2 (vector 8. 16. 30.))
                   (v3 (vector 10. 0. 0.))
                   (v4 (vector 0. 1. 0.))
                   )
              (and
               ;; (vector3-equal? (vector3-rotate v4 q) (vector 0. 0. 1.))
               (vector3-equal? (vector3-normalize v3) (vector 1. 0. 0.))
               (vector3-equal? (vector3-average v1 v2) (vector 6. 10. 17.))
               (vector3-equal? (vector3-scale v0 2) (vector 2. 4. 6.))
               (vector3-equal? (vector3-sum v0 v1) (vector 5. 6. 7.))
               (= (distance-between-points axis v3) 9)
               (almost= (angle-between-vectors axis v4)
                        (degrees->radians 90.)
                        0.0000000001)
               #t))

            (< (abs (- (string->number (number->pretty-string -15.1 6)) -15.1)) 0.001)
            (equal? (number->pretty-string 1123 6) "1123")
            (equal? (number->pretty-string -1123 6) "-1123")
            (equal? (number->pretty-string 0.17 4) "0.17")
            (equal? (number->pretty-string 10.0 4) "10")
            (equal? (number->pretty-string 10.1 4) "10.1")
            (equal? (number->pretty-string 10.01 4) "10.01")
            (equal? (number->pretty-string 1 4) "1")
            (equal? (number->pretty-string 2 4) "2")
            (equal? (number->pretty-string -2 4) "-2")
            (equal? (number->pretty-string -2.0 4) "-2")
            (equal? (number->pretty-string -2.1 4) "-2.1")
            (equal? (number->pretty-string -2.01 4) "-2.01")
            (equal? (number->pretty-string 9.999 4) "9.999")
            (equal? (number->pretty-string 0.999 4) "0.999")
            (equal? (number->pretty-string -0.999 4) "-0.999")
            (equal? (number->pretty-string 1.1 4) "1.1")
            (equal? (number->pretty-string 100 4) "100")
            (equal? (number->pretty-string 100.01 4) "100.01")
            (equal? (number->pretty-string 100.02 4) "100.02")
            (equal? (number->pretty-string 1000 4) "1000")
            (equal? (number->pretty-string 10000 4) "10000")
            (equal? (number->pretty-string 10000.1 4) "10000.1")
            (equal? (number->pretty-string 10000.1002 4) "10000.1002")

            ;; XXX why does this one have some mismatches?
            ;; (test-rotation-set
            ;;  (lambda (rot)
            ;;    (test-quatenion-and-euler
            ;;     euler->quaternion
            ;;     quaternion->euler
            ;;     rot)))

            (test-rotation-set
             (lambda (rot)
               (test-quatenion-and-euler
                euler->quaternion~zyx
                quaternion->euler~zyx
                rot)))

            (test-point-above-plane)

            (test-sphere-aa-box-intersection)

            )
      )))
