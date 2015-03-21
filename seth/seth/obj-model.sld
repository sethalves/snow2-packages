(define-library (seth obj-model)
  (export make-model
          read-obj-model
          read-obj-model-file
          compact-obj-model
          fix-implied-normals
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
          (seth math-3d))
  (cond-expand
   (chicken (import (extras)))
   (else))

  (begin

    ;; a model has a list of vertices and of normals. A model also has a list of meshes.
    (define-record-type <model>
      (make-model meshes vertices normals)
      model?
      (meshes model-meshes model-set-meshes!)
      (vertices model-vertices model-set-vertices!)
      (normals model-normals model-set-normals!))

    ;; a mesh is a group of triangles defined by indexing into the model's vertexes
    (define-record-type <mesh>
      (make-mesh faces)
      mesh?
      (faces mesh-faces mesh-set-faces!))

    ;; a face corner is a vertex being used as part of the definition for a face
    (define-record-type <face-corner>
      ;; indexes here are zero based
      (make-face-corner vertex-index texture-index normal-index)
      face-corner?
      (vertex-index face-corner-vertex-index face-corner-set-vertex-index!)
      (texture-index face-corner-texture-index face-corner-set-texture-index!)
      (normal-index face-corner-normal-index face-corner-set-normal-index!))


    (define (face-corner->vertex model face-corner)
      (snow-assert (model? model))
      (snow-assert (face-corner? face-corner))
      (let ((index (face-corner-vertex-index face-corner)))
        (if (eq? index 'unset) #f
            (vector-map string->number (list-ref (model-vertices model) index)))))


    (define (face-corner->normal model face-corner)
      (snow-assert (model? model))
      (snow-assert (face-corner? face-corner))
      (let ((index (face-corner-normal-index face-corner)))
        (if (eq? index 'unset) #f
            (vector-map string->number (list-ref (model-normals model) index)))))
      

    ;; a face is a vector of face-corners
    (define (face? face)
      (cond ((not (vector? face)) #f)
            (else
             (let loop ((face (vector->list face)))
               (cond ((null? face) #t)
                     ((face-corner? (car face)) (loop (cdr face)))
                     (else #f))))))


    (define (for-each-mesh model proc)
      (for-each proc (model-meshes model)))


    ;; call op with and replace every face in model.  op should accept mesh
    ;; and face and return face
    (define (operate-on-faces model op)
      (for-each-mesh
       model
       (lambda (mesh)
         (mesh-set-faces!
          mesh
          (map
           (lambda (face) (op mesh face))
           (mesh-faces mesh))))))


    ;; call op with and replace every face corner.  op should accept mesh and
    ;; face and face-corner and return face-corner.
    (define (operate-on-face-corners model op)
      (operate-on-faces
       model
       (lambda (mesh face)
         (vector-map
          (lambda (face-corner)
            (op mesh face face-corner))
          face))))



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


    (define (model-prepend-mesh model mesh)
      (snow-assert (model? model))
      (snow-assert (mesh? mesh))
      (model-set-meshes! model (cons mesh (model-meshes model))))


    (define (string-split str tester)
      (snow-assert (string? str))
      (snow-assert (procedure? tester))
      (let loop ((chars (string->list str))
                 (result '())
                 (results '()))
        (cond ((null? chars)
               (reverse (cons (list->string (reverse result)) results)))
              ((tester (car chars))
               (loop (cdr chars)
                     '()
                     (cons (list->string (reverse result)) results)))
              (else
               (loop (cdr chars)
                     (cons (car chars) result)
                     results)))))


    (define (parse-face-corner face-corner-string)
      (snow-assert (string? face-corner-string))
      (let* ((parts
              (string-split face-corner-string (lambda (c) (eqv? c #\/))))
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
      (format "~a/~a/~a"
              (unparse-index (face-corner-vertex-index face-corner))
              (unparse-index (face-corner-texture-index face-corner))
              (unparse-index (face-corner-normal-index face-corner))))


    (define (shift-face-indices face vertex-index-start normal-index-start)
      (snow-assert (face? face))
      (snow-assert (number? vertex-index-start))
      (snow-assert (number? normal-index-start))
      (vector-map
       (lambda (corner)
         (face-corner-set-vertex-index!
          corner (+ (face-corner-vertex-index corner) vertex-index-start))
         (face-corner-set-normal-index!
          corner (+ (face-corner-normal-index corner) normal-index-start)))
       face))


    (define (model-prepend-vertex model x y z)
      (snow-assert (model? model))
      (snow-assert (string? x))
      (snow-assert (string? y))
      (snow-assert (string? z))
      (model-set-vertices! model (cons (vector x y z) (model-vertices model))))


    (define (model-prepend-normal model x y z)
      (snow-assert (model? model))
      (snow-assert (string? x))
      (snow-assert (string? y))
      (snow-assert (string? z))
      (model-set-normals! model (cons (vector x y z) (model-normals model))))


    (define (mesh-prepend-face mesh face-corner-strings
                               vertex-index-start normal-index-start inport)
      (snow-assert (mesh? mesh))
      (snow-assert (list? face-corner-strings))
      (let* ((parsed-corners (map parse-face-corner face-corner-strings))
             (face (list->vector parsed-corners)))
        (shift-face-indices face vertex-index-start normal-index-start)
        (mesh-set-faces! mesh (cons face (mesh-faces mesh)))))


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


    (define (read-mesh model vertex-index-start normal-index-start inport)
      (snow-assert (model? model))
      (snow-assert (input-port? inport))
      (let ((mesh (make-mesh '())))
        (define (done result)
          (cond ((not (null? (mesh-faces mesh)))
                 (mesh-set-faces! mesh (reverse (mesh-faces mesh)))
                 (model-prepend-mesh model mesh)))
          result)
        (let loop ()
          (let ((line (read-line inport)))
            (cond ((eof-object? line) (done #f))
                  (else
                   ;; consume the next line
                   (let* ((line-trimmmed (string-trim-both line)))
                     (cond ((= (string-length line-trimmmed) 0) (loop))
                           ((eqv? (string-ref line-trimmmed 0) #\#) (loop))
                           (else
                            (let* ((line-hndl
                                    (open-input-string line-trimmmed))
                                   (nt (lambda ()
                                         (next-token '(#\space)
                                                     '(#\space *eof*)
                                                     #\# line-hndl)))
                                   (first-token (nt)))
                              (cond ((equal? first-token "v")
                                     (let* ((x (nt)) (y (nt)) (z (nt)))
                                       (model-prepend-vertex model x y z)
                                       (loop)))
                                    ((equal? first-token "vn")
                                     (let* ((x (nt)) (y (nt)) (z (nt)))
                                       (model-prepend-normal model x y z)
                                       (loop)))
                                    ((equal? first-token "f")
                                     (mesh-prepend-face
                                      mesh (read-face nt) vertex-index-start
                                      normal-index-start inport)
                                     (loop))
                                    ((equal? first-token "g")
                                     (done #t))
                                    (else
                                     (loop)))))))))))))


    (define (read-obj-model inport . maybe-model)
      (snow-assert (input-port? inport))
      (let ((model (if (null? maybe-model)
                       (make-model '() '() '())
                       (car maybe-model))))
        (snow-assert (model? model))
        (let loop ()
          (cond ((read-mesh model
                            (length (model-vertices model))
                            (length (model-normals model))
                            inport)
                 (loop))
                (else
                 (model-set-meshes! model (reverse (model-meshes model)))
                 (model-set-vertices! model (reverse (model-vertices model)))
                 (model-set-normals! model (reverse (model-normals model)))
                 model)))))


    (define (read-obj-model-file input-file-name . maybe-model)
      (snow-assert (string? input-file-name))
      (let ((model (if (null? maybe-model) #f (car maybe-model))))
        (snow-assert (model? model))
        (read-obj-model (open-input-file input-file-name) model)))


    (define (write-obj-model model port)
      (snow-assert (model? model))
      (snow-assert (output-port? port))
      (for-each
       (lambda (vertex)
         (display (format "v ~a ~a ~a"
                          (vector-ref vertex 0)
                          (vector-ref vertex 1)
                          (vector-ref vertex 2)) port)
         (newline port))
       (model-vertices model))
      (newline port)

      (for-each
       (lambda (normal)
         (display (format "vn ~a ~a ~a"
                          (vector-ref normal 0)
                          (vector-ref normal 1)
                          (vector-ref normal 2)) port)
         (newline port))
       (model-normals model))

      (let loop ((meshes (model-meshes model))
                 (nth 1))
        (cond ((null? meshes) #t)
              (else 
               (display (format "\ng mesh-~a\n" nth) port)
               (let ((mesh (car meshes)))
                 (for-each
                  (lambda (face)
                    (display (format "f ~a"
                                     (string-join
                                      (vector->list
                                       (vector-map unparse-face-corner face)))
                                     port))
                    (newline port))
                  (mesh-faces mesh))
                 (loop (cdr meshes) (+ nth 1)))))))



    (define (compact-obj-model model)
      ;; fix a model that has repeated points

      (define (remap-index index orig-vector new-ht)
        (snow-assert (or (eq? index 'unset) (number? index)))
        (snow-assert (vector? orig-vector))
        (snow-assert (hash-table? new-ht))
        (cond ((equal? index 'unset) 'unset)
              (else
               (let* ((old-value (vector-ref orig-vector index))
                      (old-key (string-join (vector->list old-value))))
                 (hash-table-ref new-ht old-key)))))

      (snow-assert (model? model))

      (let ((original-vertices (list->vector (model-vertices model)))
            (new-vertices '())
            (vertex-ht (make-hash-table))
            (vertex-n 0)
            (original-normals (list->vector (model-normals model)))
            (new-normals '())
            (normal-ht (make-hash-table))
            (normal-n 0))

        (for-each
         (lambda (vertex)
           (let ((key (string-join (vector->list vertex))))
             (cond ((not (hash-table-exists? vertex-ht key))
                    (hash-table-set! vertex-ht key vertex-n)
                    (set! vertex-n (+ vertex-n 1))
                    (set! new-vertices (cons vertex new-vertices))))))
         (model-vertices model))

        (for-each
         (lambda (normal)
           (let ((key (string-join (vector->list normal))))
             (cond ((not (hash-table-exists? normal-ht key))
                    (hash-table-set! normal-ht key normal-n)
                    (set! normal-n (+ normal-n 1))
                    (set! new-normals (cons normal new-normals))))))
         (model-normals model))

        (model-set-vertices! model (reverse new-vertices))
        (model-set-normals! model (reverse new-normals))

        (operate-on-face-corners
         model
         (lambda (mesh face face-corner)
           (make-face-corner
            (remap-index (face-corner-vertex-index face-corner)
                         original-vertices vertex-ht)
            (face-corner-texture-index face-corner)
            (remap-index (face-corner-normal-index face-corner)
                         original-normals normal-ht))))
        ))


    (define (fix-implied-normals model)
      (snow-assert (model? model))
      ;; obj files should have counter-clockwise points.  If we read normals
      ;; and the ordering on the points that define a face suggest that
      ;; the normal is more than 90 degrees off of the read normal,
      ;; flip the ordering of the points in the face.
      (operate-on-faces
       model
       (lambda (mesh face)
         (snow-assert (mesh? mesh))
         (snow-assert (face? face))
         (let ((vertices (vector-map
                          (lambda (face-corner)
                            (face-corner->vertex model face-corner))
                          face)))
           ;; a face might be defined by more than 3 vertices.  if so, punt.
           (cond ((= (vector-length vertices) 3)
                  (let ((normals
                         `(,(face-corner->normal model (vector-ref face 0))
                           ,(face-corner->normal model (vector-ref face 1))
                           ,(face-corner->normal model (vector-ref face 2))))
                        (vertex-0 (vector-ref vertices 0))
                        (vertex-1 (vector-ref vertices 1))
                        (vertex-2 (vector-ref vertices 2)))
                    (if (memq 'unset normals)
                        ;; if any of the normals a missing don't try.
                        face
                        ;; we have 3 vertices with 3 normals.
                        ;; average the normals
                        (let* ((normal (apply vector3-average normals))
                               ;; get cross-product of triangle sides
                               (diff-1-0 (vector3-diff vertex-1 vertex-0))
                               (diff-2-0 (vector3-diff vertex-2 vertex-0))
                               (cross (cross-product diff-1-0 diff-2-0))
                               ;; angle between implied normal and read one
                               (angle-between
                                (angle-between-vectors
                                 normal cross (cross-product normal cross))))
                          (cond ((> (abs angle-between) pi/2)
                                 ;; the angles don't agree, so flip the face
                                 (vector (vector-ref face 0)
                                         (vector-ref face 2)
                                         (vector-ref face 1)))
                                ;; the angles agree, leave it alone.
                                (else face))))))
                 ;; not 3 vertices in face.
                 (else face))))))
    
    ))
