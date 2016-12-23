(define-library (seth model-3d)
  (export
   ;; coordinates
   make-coordinates
   coordinates-append!
   coordinates?
   coordinates-length
   coordinates-ref
   coordinates-as-vector
   ;; models
   make-model
   make-empty-model
   model?
   model-meshes model-set-meshes!
   model-vertices model-set-vertices!
   model-texture-coordinates model-set-texture-coordinates!
   model-normals model-set-normals!
   model-material-libraries model-set-material-libraries!
   model-materials model-set-materials!
   model-prepend-mesh!
   model-get-material-by-name
   model-aa-box
   model-dimensions
   model-max-dimension
   model-texture-aa-box
   model-clear-texture-coordinates!
   model-append-texture-coordinate!
   model-append-vertex!
   model-append-normal!
   ;; materials
   make-material
   material?
   material-name material-set-name!
   add-simple-texture-coordinates
   ray-cast
   add-top-texture-coordinates
   set-all-faces-to-material
   clear-material-libraries
   add-material-library
   add-material-libraries
   ;; meshes
   make-mesh
   mesh?
   mesh-name mesh-set-name!
   mesh-faces mesh-set-faces!
   mesh-prepend-face!
   mesh-append-face!
   mesh-sort-faces-by-material-name
   ;; face-corners
   make-face-corner
   face-corner?
   face-corner-vertex-index face-corner-set-vertex-index!
   face-corner-texture-index face-corner-set-texture-index!
   face-corner-normal-index face-corner-set-normal-index!
   face-corner->vertex
   face-corner->normal
   ;; faces
   make-face
   model-contains-face
   model-contains-equivalent-face
   face?
   face-is-degenerate?
   face-corners face-set-corners!
   face-material face-set-material!
   face->vertices
   face->vertices-list
   face->aa-box
   face->center-vertex
   face->normals
   face->average-normal
   face-set-normals!
   fix-face-winding
   shift-face-indices
   ;; mapers/iterators
   for-each-mesh
   for-each-face
   for-each-face-corner
   operate-on-faces
   operate-on-face-corners
   ;; utilities
   combine-near-points
   compact-obj-model
   scale-model
   size-model
   translate-model
   model->octree
   )

  (import (scheme base)
          (scheme file)
          (scheme write)
          (scheme cxr)
          (srfi 1)
          (srfi 13)
          (srfi 29)
          (srfi 69)
          (srfi 95)
          (snow assert)
          (snow input-parse)
          (seth cout)
          (seth math-3d)
          (seth octree))

  (cond-expand
   (chicken (import (extras)))
   (else))

  (begin

    (define vector-tolerance 0.000001)

    ;; a generic sequence of vectors of strings (coordinates)
    (define-record-type <coordinates>
      (make-coordinates~ vec rev-lst lst-len)
      coordinates?
      (vec coordinates-vec coordinates-set-vec!)
      (rev-lst coordinates-lst coordinates-set-lst!)
      (lst-len coordinates-lst-len coordinates-set-lst-len!))

    (define (make-coordinates)
      (make-coordinates~ (vector) (list) 0))

    (define (coordinates-append! coords new-coord)
      (snow-assert (coordinates? coords))
      (snow-assert (vector? new-coord))
      (snow-assert (every string? (vector->list new-coord)))
      (coordinates-set-lst!
       coords
       (cons new-coord (coordinates-lst coords)))
      (coordinates-set-lst-len!
       coords
       (+ (coordinates-lst-len coords) 1)))

    (define (coordinates-compact coords)
      (snow-assert (coordinates? coords))
      (cond ((not (null? (coordinates-lst coords)))
             (coordinates-set-vec!
              coords
              (vector-append
               (coordinates-vec coords)
               (list->vector (reverse (coordinates-lst coords)))))
             (coordinates-set-lst! coords '())
             (coordinates-set-lst-len! coords 0))))

    (define (coordinates-length coords)
      (+ (vector-length (coordinates-vec coords))
         (coordinates-lst-len coords)))

    (define (coordinates-ref coords n)
      (coordinates-compact coords)
      (vector-ref (coordinates-vec coords) n))

    (define (coordinates-as-vector coords)
      (coordinates-compact coords)
      (coordinates-vec coords))

    (define (coordinates-null? coords)
      (coordinates-compact coords)
      (= (vector-length (coordinates-vec coords)) 0))


    ;; a model has a list of vertices and of normals. A model also has a
    ;; list of meshes.
    (define-record-type <model>
      (make-model~ meshes vertices texture-coordinates normals
                  material-libraries materials)
      model?
      (meshes model-meshes model-set-meshes!) ;; list of meshes
      (vertices model-vertices model-set-vertices!) ;; coordinates
      (texture-coordinates model-texture-coordinates
                           model-set-texture-coordinates!)  ;; coordinates
      (normals model-normals model-set-normals!)  ;; coordinates
      (material-libraries model-material-libraries
                          model-set-material-libraries!)
      (materials model-materials model-set-materials!))

    (define (make-model meshes vertices texture-coordinates normals
                        material-libraries materials)
      (snow-assert (list? meshes))
      (snow-assert (coordinates? vertices))
      (snow-assert (coordinates? texture-coordinates))
      (snow-assert (coordinates? normals))
      (snow-assert (list? material-libraries))
      (snow-assert (hash-table? materials))
      (make-model~ meshes vertices texture-coordinates normals
                   material-libraries materials))

    (define (make-empty-model)
      (make-model '()
                  (make-coordinates) (make-coordinates) (make-coordinates)
                  '() (make-hash-table)))


    ;; a material is a reference into an external .mtl file
    (define-record-type <material>
      (make-material name)
      material?
      (name material-name material-set-name!))

    ;; look up a material by name.  if this is the first reference to
    ;; it, create it.
    (define (model-get-material-by-name model material-name)
      (snow-assert (model? model))
      (snow-assert (or (string? material-name) (not material-name)))
      (cond ((not material-name) #f)
            (else
             (let ((materials (model-materials model)))
               (cond ((hash-table-exists? materials material-name)
                      (hash-table-ref materials material-name))
                     (else
                      (let ((new-material (make-material material-name)))
                        (hash-table-set! materials material-name new-material)
                        new-material)))))))


   ;; a mesh is a group of triangles defined by indexing into the
    ;; model's vertexes
    (define-record-type <mesh>
      (make-mesh name faces)
      mesh?
      (name mesh-name mesh-set-name!)
      (faces mesh-faces mesh-set-faces~!))

    (define (mesh-set-faces! mesh faces)
      (snow-assert (mesh? mesh))
      (snow-assert (list? faces))
      (for-each
       (lambda (face)
         (snow-assert (face? face)))
       faces)
      (mesh-set-faces~! mesh faces))



    ;; a face corner is a vertex being used as part of the definition for a face
    (define-record-type <face-corner>
      ;; indexes here are zero based
      (make-face-corner~ vertex-index texture-index normal-index)
      face-corner?
      (vertex-index face-corner-vertex-index face-corner-set-vertex-index!)
      (texture-index face-corner-texture-index face-corner-set-texture-index!)
      (normal-index face-corner-normal-index face-corner-set-normal-index!))


    (define (make-face-corner vertex-index texture-index normal-index)
      (snow-assert (integer? vertex-index))
      (snow-assert (or (integer? texture-index) (eq? texture-index 'unset)))
      (snow-assert (or (integer? normal-index) (eq? normal-index 'unset)))
      (make-face-corner~ vertex-index texture-index normal-index))


    ;; a face is a list of face corners and a material
    (define-record-type <face>
      (make-face~ corners material)
      face?
      (corners face-corners face-set-corners!) ;; corners is a vector
      (material face-material face-set-material!))


    (define (make-face model corners material)
      (snow-assert (model? model))
      (snow-assert (vector? corners))
      (vector-for-each
       (lambda (corner)
         (snow-assert (face-corner? corner)))
       corners)
      (snow-assert (or (material? material) (not material)))
      (make-face~ corners material))


    (define (model-contains-face model face)
      (define (face->sorted-indices f)
        (let* ((corners (vector->list (face-corners f)))
               (indices (map face-corner-vertex-index corners)))
          (sort indices)))
      ;; search model for a face with the same vertices
      (let ((face-indices-sorted (face->sorted-indices face))
            (result #f))
        (operate-on-faces
         model
         (lambda (mesh other-face)
           (if (equal? (face->sorted-indices other-face) face-indices-sorted)
               (set! result #t))
           other-face))
        result))

    (define (model-contains-equivalent-face model face tolerance)
      (let ((face-as-vertices (sort (face->vertices-list model face)))
            (result #f))
        (operate-on-faces
         model
         (lambda (mesh other-face)
           (let ((other-vertices (sort (face->vertices-list model other-face))))
             (let loop ((face-as-vertices face-as-vertices)
                        (other-vertices other-vertices))
               (cond ((and (null? face-as-vertices) (null? other-vertices))
                      (set! result #t))
                     ((null? face-as-vertices) #t)
                     ((null? other-vertices) #t)
                     ((not (vector3-almost-equal? (car face-as-vertices) (car other-vertices) tolerance))
                      #t)
                     (else
                      (loop (cdr face-as-vertices) (cdr other-vertices)))))
             )
           other-face))
        result))


    (define (vertex-deltas vertices)
      (let loop ((vertices-lst vertices)
                 (deltas (list)))
        (cond ((null? vertices-lst)
               (reverse deltas))
              ((null? (cdr vertices-lst))
               (let ((v0 (car vertices-lst))
                     (v1 (car vertices)))
                 (loop (cdr vertices-lst)
                       (cons (vector3-diff v1 v0) deltas))))
              (else
               (let ((v0 (car vertices-lst))
                     (v1 (cadr vertices-lst)))
                 (loop (cdr vertices-lst)
                       (cons (vector3-diff v1 v0) deltas)))))))

    (define (face-has-vertices-in-a-line model face)
      (snow-assert (model? model))
      (snow-assert (face? face))
      (let loop ((deltas (vertex-deltas (face->vertices-list model face))))
        (if (or (null? deltas)
                (null? (cdr deltas)))
            #f ;; not degenerate
            (let ((next-delta (car deltas))
                  (other-delta (cadr deltas)))
              (cond ((vector3-almost-equal?
                      next-delta zero-vector vector-tolerance)
                     #t)
                    ((vector3-almost-equal?
                      (vector3-normalize next-delta)
                      (vector3-normalize other-delta)
                      vector-tolerance)
                     #t)
                    ((vector3-almost-equal?
                      (vector3-scale (vector3-normalize next-delta) -1.0)
                      (vector3-normalize other-delta)
                      vector-tolerance)
                     #t)
                    (else (loop (cdr deltas))))))))


    (define (face-has-concurrent-vertices model face)
      (snow-assert (model? model))
      (snow-assert (face? face))
      (let loop ((vertices (face->vertices-list model face)))
        (if (or (null? vertices)
                (null? (cdr vertices)))
            #f ;; not degenerate, according to this part of the test
            (let ((next-vertex (car vertices))
                  (other-vertices (cdr vertices)))
              (let inner-loop ((other-vertices other-vertices))
                (cond ((null? other-vertices) (loop (cdr vertices)))
                      ((vector3-almost-equal?
                        next-vertex
                        (car other-vertices)
                        vector-tolerance)
                       #t)
                      (else (inner-loop (cdr other-vertices)))))))))

    (define (face-is-degenerate? model face)
      (snow-assert (model? model))
      (snow-assert (face? face))
      (cond ((face-has-concurrent-vertices model face) #t)
            ((face-has-vertices-in-a-line model face) #t)
            (else #f)))

    (define (model-clear-texture-coordinates! model)
      (model-set-texture-coordinates! model (make-coordinates)))


    (define (model-append-texture-coordinate! model v)
      (snow-assert (model? model))
      (snow-assert (vector? v))
      (snow-assert (= (vector-length v) 2))
      (coordinates-append! (model-texture-coordinates model) v))


    (define (face-corner->vertex model face-corner)
      (snow-assert (model? model))
      (snow-assert (face-corner? face-corner))
      (let ((index (face-corner-vertex-index face-corner)))
        (if (eq? index 'unset) #f
            (vector-map string->number
                        (coordinates-ref (model-vertices model) index)))))


    (define (face-corner->normal model face-corner)
      (snow-assert (model? model))
      (snow-assert (face-corner? face-corner))
      (let ((index (face-corner-normal-index face-corner)))
        (if (eq? index 'unset) 'unset
            (vector-map string->number
                        (coordinates-ref (model-normals model) index)))))


    (define (for-each-mesh model proc)
      (snow-assert (model? model))
      (for-each proc (model-meshes model)))


    (define (for-each-face model proc)
      (snow-assert (model? model))
      (for-each-mesh
       model
       (lambda (mesh)
         (for-each
          proc
          (mesh-faces mesh)))))

    (define (for-each-face-corner model proc)
      (snow-assert (model? model))
      (for-each-face
       model
       (lambda (face)
         (for-each
          proc
          (face-corners face)))))


    ;; call op with and replace every face in model.  op should accept mesh
    ;; and face and return face
    (define (operate-on-faces model op)
      (snow-assert (model? model))
      (for-each-mesh
       model
       (lambda (mesh)
         (snow-assert (mesh? mesh))
         (mesh-set-faces!
          mesh
          (map
           (lambda (face) (op mesh face))
           (mesh-faces mesh))))))


    ;; call op with and replace every face corner.  op should accept mesh and
    ;; face and face-corner and return face-corner.
    (define (operate-on-face-corners model op)
      (snow-assert (model? model))
      (operate-on-faces
       model
       (lambda (mesh face)
         (snow-assert (mesh? mesh))
         (snow-assert (face? face))
         (face-set-corners!
          face
          (vector-map
           (lambda (face-corner)
             (snow-assert (face-corner? face-corner))
             (let ((op-result (op mesh face face-corner)))
               (snow-assert (face-corner? op-result))
               op-result))
           (face-corners face)))
         face)))


    ;; a face includes a vector of indexes into the models vertices.  turn
    ;; a face into a vector of vertices.
    (define (face->vertices model face)
      (snow-assert (model? model))
      (snow-assert (face? face))
      (vector-map
       (lambda (face-corner)
         (snow-assert (face-corner? face-corner))
         (face-corner->vertex model face-corner))
       (face-corners face)))

    (define (face->vertices-list model face)
      (vector->list (face->vertices model face)))


    (define (face->aa-box model face)
      (let ((aa-box (make-empty-3-aa-box)))
        (for-each (lambda (p) (aa-box-add-point! aa-box p))
                  (face->vertices-list model face))
        aa-box))


    (define (face->center-vertex model face)
      (vector3-scale
       (fold vector3-sum (vector 0 0 0) (face->vertices-list model face))
       (/ 1.0 (vector-length (face-corners face)))))


    (define (face->normals model face)
      (snow-assert (model? model))
      (snow-assert (face? face))
      (vector-map
       (lambda (face-corner)
         (snow-assert (face-corner? face-corner))
         (face-corner->normal model face-corner))
       (face-corners face)))


    (define (face->average-normal model face)
      (let* ((vertices (face->vertices model face))
             (v10 (vector3-diff (vector-ref vertices 1) (vector-ref vertices 0)))
             (v20 (vector3-diff (vector-ref vertices 2) (vector-ref vertices 0))))
        (vector3-normalize (cross-product v10 v20))))


    (define (model-prepend-mesh! model mesh)
      (snow-assert (model? model))
      (snow-assert (mesh? mesh))
      (model-set-meshes! model (cons mesh (model-meshes model))))



    (define (shift-face-indices
             face vertex-index-start texture-index-start normal-index-start)
      (snow-assert (face? face))
      (snow-assert (integer? vertex-index-start))
      (snow-assert (integer? texture-index-start))
      (snow-assert (integer? normal-index-start))
      (vector-map
       (lambda (corner)
         (snow-assert (face-corner? corner))
         (face-corner-set-vertex-index!
          corner (+ (face-corner-vertex-index corner) vertex-index-start))
         (if (not (eq? (face-corner-texture-index corner) 'unset))
             (face-corner-set-texture-index!
              corner (+ (face-corner-texture-index corner)
                        texture-index-start)))
         (if (not (eq? (face-corner-normal-index corner) 'unset))
             (face-corner-set-normal-index!
              corner (+ (face-corner-normal-index corner)
                        normal-index-start))))
       (face-corners face)))


    (define (model-append-vertex! model v)
      ;; returns the index of the new vertex
      (snow-assert (model? model))
      (snow-assert (vector? v))
      (snow-assert (= (vector-length v) 3))
      (snow-assert (string? (vector-ref v 0)))
      (snow-assert (string? (vector-ref v 1)))
      (snow-assert (string? (vector-ref v 2)))
      (coordinates-append! (model-vertices model) v)
      (- (coordinates-length (model-vertices model)) 1))


    (define (model-append-normal! model v)
      ;; returns the index of the new normal
      (snow-assert (model? model))
      (snow-assert (vector? v))
      (snow-assert (= (vector-length v) 3))
      (snow-assert (string? (vector-ref v 0)))
      (snow-assert (string? (vector-ref v 1)))
      (snow-assert (string? (vector-ref v 2)))
      (coordinates-append! (model-normals model) v)
      (- (coordinates-length (model-normals model)) 1))


    (define (mesh-prepend-face! model mesh face-corners material
                                vertex-index-start texture-index-start
                                normal-index-start inport)
      (snow-assert (mesh? mesh))
      (snow-assert (list? face-corners))
      (let ((face (make-face model (list->vector face-corners) material)))
        (cond ((not (face-is-degenerate? model face))
               (shift-face-indices
                face vertex-index-start texture-index-start normal-index-start)
               (mesh-set-faces! mesh (cons face (mesh-faces mesh))))
              (else
               (cerr "warning: face is degenerate: "
                     (map
                      (lambda (face-corner) (face-corner->vertex model face-corner))
                      face-corners)
                     "\n"))
              )))


    (define (mesh-append-face! model mesh face)
      (snow-assert (model? model))
      (snow-assert (mesh? mesh))
      (snow-assert (face? face))
      (mesh-set-faces! mesh (reverse (cons face (reverse (mesh-faces mesh))))))


    (define (mesh-sort-faces-by-material-name model mesh)
      (mesh-set-faces!
       mesh
       (sort (mesh-faces mesh) (lambda (a b)
                                 (let* ((material-a (face-material a))
                                        (material-b (face-material b))
                                        (material-name-a
                                         (if material-a (material-name material-a) ""))
                                        (material-name-b
                                         (if material-b (material-name material-b) "")))
                                   (string<? material-name-a material-name-b))))))



    (define (combine-near-points model threshold)
      (snow-assert (model? model))
      ;; make a mapping of vertex index to count of nearby vertexes
      (let* ((coords (model-vertices model))
             (vertices (coordinates-as-vector coords))
             (vertex-index->neighbor-count
              (vector-map
               (lambda (vertex)
                 (snow-assert (vector? vertex))
                 (snow-assert (= (vector-length vertex) 3))
                 (let ((neighbor-count 0))
                   (let loop ((j 0))
                     (cond ((= j (vector-length vertices)) #t)
                           ((eq? vertex (vector-ref vertices j))
                            (loop (+ j 1)))
                           ((>= (distance-between-points vertex (vector-ref vertices j)) threshold)
                            (set! neighbor-count (+ neighbor-count 1))
                            (loop (+ j 1)))
                           (else
                            (loop (+ j 1)))))
                   neighbor-count))
               vertices)))
        (cerr vertex-index->neighbor-count "\n")
        ;;
        ;; TODO finish this
        ;;

        #t))


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

      (let ((original-vertices (coordinates-as-vector (model-vertices model)))
            (new-vertices (make-coordinates))
            (vertex-ht (make-hash-table))
            (vertex-n 0)
            (original-normals (coordinates-as-vector (model-normals model)))
            (new-normals (make-coordinates))
            (normal-ht (make-hash-table))
            (normal-n 0))

        (vector-for-each
         (lambda (vertex)
           (let ((key (string-join (vector->list vertex))))
             (cond ((not (hash-table-exists? vertex-ht key))
                    (hash-table-set! vertex-ht key vertex-n)
                    (set! vertex-n (+ vertex-n 1))
                    (coordinates-append! new-vertices vertex)))))
         (coordinates-as-vector (model-vertices model)))

        (vector-for-each
         (lambda (normal)
           (let ((key (string-join (vector->list normal))))
             (cond ((not (hash-table-exists? normal-ht key))
                    (hash-table-set! normal-ht key normal-n)
                    (set! normal-n (+ normal-n 1))
                    (coordinates-append! new-normals normal)))))
         (coordinates-as-vector (model-normals model)))

        (model-set-vertices! model new-vertices)
        (model-set-normals! model new-normals)


        (operate-on-face-corners
         model
         (lambda (mesh face face-corner)
           (snow-assert (mesh? mesh))
           (snow-assert (face? face))
           (snow-assert (face-corner? face-corner))

           (make-face-corner
            (remap-index (face-corner-vertex-index face-corner)
                         original-vertices vertex-ht)
            (face-corner-texture-index face-corner) ;; XXX compact these also
            (remap-index (face-corner-normal-index face-corner)
                         original-normals normal-ht))
           ))
        ))

    (define (get-normal-wrongness vertex-0 vertex-1 vertex-2 normals)
      ;; angle between implied normal and read one
      (let* ((normal (apply vector3-average normals))
             ;; get cross-product of triangle sides
             (diff-1-0 (vector3-diff vertex-1 vertex-0))
             (diff-2-0 (vector3-diff vertex-2 vertex-0))
             (cross (cross-product diff-1-0 diff-2-0))
             (normal-cross (cross-product normal cross)))
        (cond ((vector3-equal? normal-cross zero-vector)
               (if (vector3-almost-equal?
                    (vector3-normalize normal)
                    (vector3-normalize cross)
                    vector-tolerance)
                   0 ;; don't flip
                   pi)) ;; flip
              (else
               (angle-between-vectors normal cross normal-cross)))))


    (define (face-set-normals! model face)
      (let* ((vertices (face->vertices model face))
             (vertex-0 (vector-ref vertices 0))
             (vertex-1 (vector-ref vertices 1))
             (vertex-2 (vector-ref vertices 2))
             (diff-1-0 (vector3-diff vertex-1 vertex-0))
             (diff-2-0 (vector3-diff vertex-2 vertex-0))
             (normal (cross-product diff-1-0 diff-2-0))
             (normal-normalized (vector3-normalize normal))
             (normal-s (vector-map number->string normal-normalized))
             (normal-index (model-append-normal! model normal-s)))
        (for-each
         (lambda (corner)
           (face-corner-set-normal-index! corner normal-index))
         (vector->list (face-corners face)))))

    (define (fix-face-winding model)
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
         (let ((vertices (face->vertices model face))
               (corners (face-corners face)))
           ;; a face might be defined by more than 3 vertices.  if so, punt.
           (cond ((= (vector-length vertices) 3)
                  (let ((normals
                         `(,(face-corner->normal model (vector-ref corners 0))
                           ,(face-corner->normal model (vector-ref corners 1))
                           ,(face-corner->normal model (vector-ref corners 2))))
                        (vertex-0 (vector-ref vertices 0))
                        (vertex-1 (vector-ref vertices 1))
                        (vertex-2 (vector-ref vertices 2)))
                    (if (memq 'unset normals)
                        ;; if any of the normals are missing don't try.
                        face
                        ;; we have 3 vertices with 3 normals.
                        ;; average the normals
                        (let ((angle-between (get-normal-wrongness
                                              vertex-0 vertex-1 vertex-2
                                              normals)))
                          (cond ((> (abs angle-between) pi/2)
                                 ;; the angles don't agree, so flip the face
                                 (face-set-corners!
                                  face
                                  (vector (vector-ref corners 0)
                                          (vector-ref corners 2)
                                          (vector-ref corners 1)))
                                 face)
                                ;; the angles agree, leave it alone.
                                (else face))))))
                 ;; not 3 vertices in face, pass it back unchanged.
                 (else face))))))


    (define (pick-u-v-axis~ vertices)
      (snow-assert (vector? vertices))
      (snow-assert (> (vector-length vertices) 2))
      (let* ((vertex-0 (vector-ref vertices 0))
             (vertex-1 (vector-ref vertices 1))
             (vertex-last (vector-ref vertices (- (vector-length vertices) 1)))
             ;; pick u and v axis.  u is along the line from vertex-0
             ;; to vertex-1.  v is perpendicular to the u axis and to
             ;; the normal of the triangle.
             (u-axis (vector3-normalize (vector3-diff vertex-1 vertex-0)))
             (diff-last-0 (vector3-diff vertex-last vertex-0))
             (normal (cross-product u-axis diff-last-0))
             (v-axis (vector3-normalize (cross-product normal u-axis))))
        (values u-axis v-axis)))


    (define (pick-u-v-axis vertices)
      (snow-assert (vector? vertices))
      (snow-assert (> (vector-length vertices) 2))
      (let* ((vertex-0 (vector-ref vertices 0))
             (vertex-1 (vector-ref vertices 1))
             (vertex-last (vector-ref vertices (- (vector-length vertices) 1)))
             (diff-1-0 (vector3-diff vertex-1 vertex-0))
             (diff-last-0 (vector3-diff vertex-last vertex-0))
             (normal (cross-product diff-1-0 diff-last-0))

             (sx (vector3-normalize #(1 0 0)))
             (sy (vector3-normalize #(0 1 0)))
             (sz (vector3-normalize #(0 0 1)))
             (best-normal-axis (worst-aligned-vector normal (list sx sy sz)))

             (center (vector3-scale
                      (apply vector3-sum (vector->list vertices))
                      (/ 1.0 (vector-length vertices))))
             (plane-intersection (triangle-plane-intersection
                                  vertices (vector center best-normal-axis))))
        (cond ((not plane-intersection)
               (pick-u-v-axis~ vertices))

              ;; ((vector3-almost-equal? normal zero-vector vector-tolerance)
              ;;  (pick-u-v-axis~ vertices))

              (else
               (let* ((u0 (vector-ref plane-intersection 0))
                      (u1 (vector-ref plane-intersection 1))
                      (u-direction (vector3-diff u1 u0))
                      (u-axis (vector3-normalize u-direction))
                      (v-axis (vector3-normalize
                               (cross-product normal u-axis))))
                 (values u-axis v-axis))))))


    (define (add-simple-texture-coordinates model scale material face-filter)
      ;; transform each face to the corner of some supposed texture and decide
      ;; on reasonable texture coords for the face.
      (snow-assert (model? model))
      ;; erase all the existing texture coordinates
      ;; (model-clear-texture-coordinates! model)
      ;; set new texture coordinates for every face
      (operate-on-faces
       model
       (lambda (mesh face)
         (snow-assert (mesh? mesh))
         (snow-assert (face? face))
         (if (face-filter model mesh face)
             (let ((vertices (face->vertices model face)))
               (snow-assert (> (vector-length vertices) 2))
               (let-values (((u-axis v-axis) (pick-u-v-axis vertices)))
                 (let* ((vertex-0 (vector-ref vertices 0))
                        ;; vertex-transformer takes a vertex in 3 space and maps
                        ;; it into the coordinate system defined by the axis
                        ;; we defined, above.
                        (vertex-transformer
                         (lambda (vertex x-offset)
                           (let* ((dv (vector3-diff vertex vertex-0))
                                  (x (+ (dot-product u-axis dv) x-offset))
                                  (y (dot-product v-axis dv)))
                             (vector (* (vector2-x scale) x) (* (vector2-y scale) y)))))
                        (vertex-transformer-no-offset
                         (lambda (vertex) (vertex-transformer vertex 0.0)))
                        ;; figure out how much we have to slide this face over
                        ;; in order to have all the uv coord be positive.
                        (un-offset-uvs
                         (vector->list
                          (vector-map vertex-transformer-no-offset vertices)))
                        (offset
                         (- (apply min (map vector2-x un-offset-uvs)))))

                   (vector-for-each
                    (lambda (face-corner)
                      (snow-assert (face-corner? face-corner))
                      (let ((index (coordinates-length
                                    (model-texture-coordinates model)))
                            (vertex (face-corner->vertex model face-corner)))
                        (model-append-texture-coordinate!
                         model
                         (vector-map
                          (lambda (v) (number->pretty-string v 6))
                          (vertex-transformer vertex offset)))
                        (face-corner-set-texture-index! face-corner index)))
                    (face-corners face))))
               (face-set-material! face material)))
         face)))


    (define (ray-cast model octree segment)
      ;; returns the closest face that the ray intersects
      (let loop ((octree-parts (octree-ray-intersection octree segment))
                 (best-face #f)
                 (best-distance #f))
        (if (null? octree-parts) best-face
            (let face-loop ((faces (octree-contents (car octree-parts)))
                            (best-face best-face)
                            (best-distance best-distance))
              (if (null? faces) (loop (cdr octree-parts) best-face best-distance)
                  (let* ((vertices (face->vertices model (car faces)))
                         (intersection-point (segment-triangle-intersection segment vertices))
                         (distance (if intersection-point
                                       (vector3-length (vector3-diff intersection-point (vector-ref segment 0)))
                                       #f)))
                    (cond ((and intersection-point (not best-face))
                           (face-loop (cdr faces) (car faces) distance))
                          ((and intersection-point (< distance best-distance))
                           (face-loop (cdr faces) (car faces) distance))
                          (else
                           (face-loop (cdr faces) best-face best-distance)))))))))



    (define (add-top-texture-coordinates model xz-scale material face-filter)
      ;; put a y-normal texture face up over the rectangle from (0,0) to xz-scale
      (snow-assert (model? model))
      (operate-on-faces
       model
       (lambda (mesh face)
         (snow-assert (mesh? mesh))
         (snow-assert (face? face))
         (cond ((face-filter model mesh face)
                (vector-for-each
                 (lambda (face-corner)
                   (snow-assert (face-corner? face-corner))
                   (let ((index (coordinates-length
                                 (model-texture-coordinates model)))
                         (vertex (face-corner->vertex model face-corner)))
                     (model-append-texture-coordinate!
                      model
                      (vector (number->pretty-string (/ (vector3-x vertex) (vector2-x xz-scale)) 6)
                              (number->pretty-string (/ (vector3-z vertex) (vector2-y xz-scale)) 6)))
                     (face-corner-set-texture-index! face-corner index)))
                 (face-corners face))
                (face-set-material! face material)))
         face)))


    (define (model-aa-box model)
      (cond ((coordinates-null? (model-vertices model)) #f)
            (else
             (let* ((p0 (vector-map
                         string->number
                         (vector-ref
                          (coordinates-as-vector (model-vertices model)) 0)))
                    (aa-box (make-aa-box p0 p0)))
               ;; insert all of the model's vertices into the axis-aligned
               ;; bounding box
               (vector-for-each
                (lambda (p)
                  (aa-box-add-point! aa-box (vector-map string->number p)))
                (coordinates-as-vector (model-vertices model)))
               aa-box))))


    (define (model-dimensions model)
      (let* ((aa-box (model-aa-box model))
             (low (aa-box-low-corner aa-box))
             (high (aa-box-high-corner aa-box)))
        (vector (- (vector-ref high 0) (vector-ref low 0))
                (- (vector-ref high 1) (vector-ref low 1))
                (- (vector-ref high 2) (vector-ref low 2)))))


    (define (model-max-dimension model)
      (vector-max (model-dimensions model)))


    (define (model-texture-aa-box model)
      (cond ((coordinates-null? (model-texture-coordinates model)) #f)
            (else
             (let* ((p0 (vector-ref (coordinates-as-vector
                                     (model-texture-coordinates model)) 0))
                    (p0-n (vector-map string->number p0))
                    (aa-box (make-aa-box p0-n p0-n)))
               ;; insert all of the model's texture-coordinates into the
               ;; axis-aligned bounding box
               (vector-for-each
                (lambda (p)
                  (aa-box-add-point! aa-box (vector-map string->number p)))
                (coordinates-as-vector (model-texture-coordinates model)))
               aa-box))))


    (define (scale-model model scaling-factor)
      (coordinates-set-vec!
       (model-vertices model)
       (vector-map
        (lambda (vertex)
          (vector-map
           (lambda (p)
             (number->pretty-string (* (string->number p) scaling-factor) 6))
           vertex))
        (coordinates-as-vector (model-vertices model)))))


    (define (size-model model desired-max-dimension)
      (let ((max-dimension (model-max-dimension model)))
        (scale-model model (/ (inexact desired-max-dimension)
                              (inexact max-dimension)))))


    (define (translate-model model by-offset)
      (snow-assert (model? model))
      (snow-assert (vector? by-offset))
      (snow-assert (= (vector-length by-offset) 3))
      (coordinates-set-vec!
       (model-vertices model)
       (vector-map
        (lambda (vertex)
          (let ((fvertex (vector-map string->number vertex)))
            (vector-map number->string (vector3-sum fvertex by-offset))))
        (coordinates-as-vector (model-vertices model)))))


    (define (set-all-faces-to-material model material-name face-filter)
      (snow-assert (model? model))
      (snow-assert (string? material-name))
      (let ((material (model-get-material-by-name model material-name)))
        (operate-on-faces
         model
         (lambda (mesh face)
           (cond ((face-filter model mesh face)
                  (face-set-material! face material)))
           face))))


    (define (clear-material-libraries model)
      (snow-assert (model? model))
      (model-set-material-libraries! model '()))


    (define (add-material-library model material-library-name)
      (snow-assert (model? model))
      (snow-assert (string? material-library-name))
      (cond ((member material-library-name (model-material-libraries model))
             #t)
            (else
             (model-set-material-libraries!
              model
              (cons material-library-name (model-material-libraries model))))))


    (define (add-material-libraries model material-library-names)
      (snow-assert (model? model))
      (for-each
       (lambda (material-library-name)
         (add-material-library model material-library-name))
       material-library-names))


    (define (model->octree model bounds)
      (let ((octree (make-octree bounds)))
        (operate-on-faces
         model
         (lambda (mesh face)
           (octree-add-element! octree face (face->aa-box model face))
           face))
        octree))

    ))
