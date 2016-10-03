(define-library (seth obj-model)
  (export read-obj-model
          read-obj-model-file
          write-obj-model)
  (import (scheme base)
          (scheme file)
          (scheme write)
          (scheme cxr)
          (scheme process-context)
          (srfi 13)
          (srfi 29)
          (srfi 69)
          (snow assert)
          (snow input-parse)
          (seth cout)
          (seth strings)
          (seth math-3d)
          (seth model-3d))
  (cond-expand
   (chicken (import (extras)))
   (else))

  (begin

    (define (parse-index index-string)
      ;; return a zero-based index value
      (snow-assert (string? index-string))
      (cond ((equal? index-string "") 'unset)
            (else
             (let ((result (- (string->number index-string) 1)))
               (snow-assert (>= result 0))
               result))))


    (define (unparse-index index)
      (snow-assert (or (number? index) (eq? index 'unset)))
      (snow-assert (or (eq? index 'unset) (>= index 0)))
      ;; return a one-based index string
      (cond ((eq? index 'unset) "")
            (else
             (number->string (+ index 1)))))


    (define (parse-face-corner face-corner-string)
      (snow-assert (string? face-corner-string))
      (let* ((parts (string-split face-corner-string #\/))
             (parts-length (length parts)))
        (cond ((= parts-length 1)
               (make-face-corner (parse-index (car parts)) 'unset 'unset))
              ((= parts-length 2)
               (make-face-corner (parse-index (car parts))
                                 (parse-index (cadr parts)) 'unset))
              ((= parts-length 3)
               (make-face-corner (parse-index (car parts))
                                 (parse-index (cadr parts))
                                 (parse-index (caddr parts))))
              (else
               (error "bad face-vertex string" face-corner-string)))))


    (define (unparse-face-corner face-corner)
      (snow-assert (face-corner? face-corner))
      (if (and (eq? (face-corner-texture-index face-corner) 'unset)
               (eq? (face-corner-normal-index face-corner) 'unset))
          (unparse-index (face-corner-vertex-index face-corner))
          (format "~a/~a/~a"
                  (unparse-index (face-corner-vertex-index face-corner))
                  (unparse-index (face-corner-texture-index face-corner))
                  (unparse-index (face-corner-normal-index face-corner)))))



    (define (read-face nt)
      (let face-loop ((face-vertex-indices '()))
        (let ((face-vertex-index (nt)))
          (cond
           ((equal? face-vertex-index "")
            (reverse face-vertex-indices))
           (else
            (face-loop
             (cons face-vertex-index
                   face-vertex-indices)))))))


    (define (tokenizer-for-line line-trimmed)
      (cond ((not line-trimmed) (lambda () #f))
            ((eof-object? line-trimmed) (lambda () #f))
            (else
             (let ((line-hndl (open-input-string line-trimmed)))
               (lambda ()
                 (next-token '(#\space) '(#\space *eof*) #\# line-hndl))))))


    (define (interpret-mesh-line line-trimmed material prepend-face! model
                                 unget-line)
      (snow-assert (material? material))
      (let* ((nt (tokenizer-for-line line-trimmed))
             (first-token (nt)))
        (cond
         ;; geometry vertex
         ((equal? first-token "v")
          (let* ((x (nt)) (y (nt)) (z (nt)))
            (model-append-vertex! model (vector x y z))
            material))
         ;; texture vertex
         ((equal? first-token "vt")
          (let* ((x (nt))
                 (y (nt)))
            (model-append-texture-coordinate!
             model (vector x y))
            material))
         ;; vertex normal
         ((equal? first-token "vn")
          (let* ((x (nt)) (y (nt)) (z (nt)))
            (model-append-normal! model (vector x y z))
            material))
         ;; face
         ((equal? first-token "f")
          (prepend-face! (map parse-face-corner (read-face nt)) material)
          material)
         ;; group
         ((equal? first-token "g")
          (unget-line line-trimmed)
          #f)
         ;; material library
         ((equal? first-token "mtllib")
          (let ((material-library (nt)))
            (model-set-material-libraries!
             model
             (cons material-library (model-material-libraries model)))
            material))
         ;; switch materials
         ((equal? first-token "usemtl")
          (let* ((next-material-name (nt))
                 (next-material
                  (model-get-material-by-name model next-material-name)))
            next-material))
         (else
          material))))


    (define (read-mesh model material prepend-face! get-line unget-line)
      ;; read an optional "g" line and all the faces after it.  stop
      ;; upon encountering another "g" line.
      (snow-assert (model? model))
      (snow-assert (material? material))
      (let ((mesh (make-mesh #f '())))

        (define (prepend-face-to-mesh! face material)
          (snow-assert (material? material))
          (prepend-face! mesh face material))

        ;; read mesh-name first
        (define mesh-name
          (let* ((mesh-name-line (get-line))
                 (nt (tokenizer-for-line mesh-name-line))
                 (first-token (nt)))
            (cond ((equal? first-token "g") (nt))
                  (else
                   ;; no "g" line, carry on without a name
                   (unget-line mesh-name-line)
                   #f))))

        (define (material-done material)
          (cond ((not (null? (mesh-faces mesh)))
                 (if mesh-name (mesh-set-name! mesh mesh-name))
                 (mesh-set-faces! mesh (reverse (mesh-faces mesh)))
                 (model-prepend-mesh! model mesh)))
          material)

        (let loop ((material material))
          (snow-assert (material? material))
          (let ((line-trimmed (get-line)))
            ;; consume the next line
            (cond ((eof-object? line-trimmed) (material-done #f))
                  (else
                   (let ((next-material
                          (interpret-mesh-line line-trimmed material
                                               prepend-face-to-mesh! model
                                               unget-line)))
                     (if next-material
                         (loop next-material)
                         (material-done material)))))))))


    (define (read-obj-model inport . maybe-model)
      (snow-assert (input-port? inport))
      (let* ((model (if (null? maybe-model)
                        (make-empty-model)
                        (car maybe-model)))
             (vertex-index-start (coordinates-length (model-vertices model)))
             (texture-index-start (coordinates-length
                                   (model-texture-coordinates model)))
             (normal-index-start (coordinates-length (model-normals model)))
             (pushed-back-line #f))

        (define (get-line)
          (if pushed-back-line
              (let ((line pushed-back-line))
                (set! pushed-back-line #f)
                line)
              (let loop ((line (read-line inport)))
                (if (eof-object? line)
                    line
                    (let ((line-trimmed (string-trim-both line)))
                      (cond ((= (string-length line-trimmed) 0)
                             (loop (read-line inport))) ;; blank line
                            ((eqv? (string-ref line-trimmed 0) #\#)
                             (loop (read-line inport))) ;; comment
                            (else
                             line-trimmed)))))))
        (define (unget-line line)
          (snow-assert (eq? pushed-back-line #f))
          (set! pushed-back-line line))


        (define (prepend-face! mesh face material)
          (if (not (face-is-degenerate? model face))
              (mesh-prepend-face! model mesh face material
                                  vertex-index-start texture-index-start
                                  normal-index-start inport)))

        (snow-assert (model? model))

        (model-set-meshes! model (reverse (model-meshes model)))

        (let loop ((material
                    (model-get-material-by-name model "default")))
          (snow-assert (material? material))
          (let ((next-material (read-mesh model
                                          material
                                          prepend-face!
                                          get-line unget-line)))
            (cond (next-material (loop next-material))
                  (else
                   (model-set-meshes! model (reverse (model-meshes model)))
                   model))))))


    (define (read-obj-model-file input-file-name . maybe-model)
      (snow-assert (string? input-file-name))
      (let ((model (if (null? maybe-model)
                       (make-model '() '() '() '() '() (make-hash-table))
                       (car maybe-model))))
        (snow-assert (model? model))
        (read-obj-model (open-input-file input-file-name) model)))


    (define (write-obj-model model port)
      (snow-assert (model? model))
      (snow-assert (output-port? port))

      (for-each
       (lambda (material-library)
         (display (format "mtllib ~a\n" material-library) port))
       (model-material-libraries model))
      (newline port)

      (vector-for-each
       (lambda (vertex)
         (display (format "v ~a ~a ~a\n"
                          (vector3-x vertex)
                          (vector3-y vertex)
                          (vector3-z vertex)) port))
       (coordinates-as-vector (model-vertices model)))
      (newline port)

      (vector-for-each
       (lambda (coord)
         (display (format "vt ~a ~a\n"
                          (vector2-x coord)
                          (vector2-y coord)) port))
       (coordinates-as-vector (model-texture-coordinates model)))
      (newline port)

      (vector-for-each
       (lambda (normal)
         (display (format "vn ~a ~a ~a\n"
                          (vector3-x normal)
                          (vector3-y normal)
                          (vector3-z normal)) port))
       (coordinates-as-vector (model-normals model)))

      (let loop ((meshes (model-meshes model))
                 (nth 1)
                 (material #f))
        (cond ((null? meshes) #t)
              (else
               (let ((mesh (car meshes))
                     (current-material material))
                 (if (mesh-name mesh)
                     (display (format "\ng ~a\n" (mesh-name mesh)) port)
                     (display (format "\ng mesh-~a\n" nth) port))
                 (for-each
                  (lambda (face)
                    (snow-assert (face? face))

                    (let ((next-material (face-material face)))
                      (cond ((not (eq? next-material current-material))
                             (display (format "usemtl ~a\n"
                                              (material-name next-material))
                                      port)
                             (set! current-material next-material)))
                      (display (format "f ~a"
                                       (string-join
                                        (vector->list
                                         (vector-map unparse-face-corner
                                                     (face-corners face)))))
                               port)
                      (newline port)))
                  (mesh-faces mesh))
                 (loop (cdr meshes) (+ nth 1) current-material))))))

    ))
