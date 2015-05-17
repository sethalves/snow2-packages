(define-library (seth model-3d)
  (export
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
   ;; materials
   make-material
   material?
   material-name material-set-name!
   ;; meshes
   make-mesh
   mesh?
   mesh-name mesh-set-name!
   mesh-faces mesh-set-faces!
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
   face?
   face-corners face-set-corners!
   face-material face-set-material!
   face->vertices
   ;; mapers/iterators
   for-each-mesh
   operate-on-faces
   operate-on-face-corners
   ;; utilities
   model-clear-texture-coordinates!
   model-append-texture-coordinate!


   )

  (import (scheme base)
          (scheme file)
          (scheme write)
          (scheme cxr)
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
      (make-model meshes vertices texture-coordinates normals material-libraries materials)
      model?
      (meshes model-meshes model-set-meshes!) ;; list of meshes
      (vertices model-vertices model-set-vertices!) ;; list of vertices
      (texture-coordinates model-texture-coordinates model-set-texture-coordinates!)
      (normals model-normals model-set-normals!)
      (material-libraries model-material-libraries model-set-material-libraries!)
      (materials model-materials model-set-materials!))

    (define (make-empty-model)
      (make-model '() '() '() '() '() (make-hash-table)))


    ;; a material is a reference into an external .mtl file
    (define-record-type <material>
      (make-material name)
      material?
      (name material-name material-set-name!))

    ;; look up a material by name.  if this is the first reference to it, create it.
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



    ;; a mesh is a group of triangles defined by indexing into the model's vertexes
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



    (define (model-clear-texture-coordinates! model)
      (model-set-texture-coordinates! model '()))


    (define (model-append-texture-coordinate! model v)
      (snow-assert (model? model))
      (snow-assert (vector? v))
      (snow-assert (= (vector-length v) 2))
      (model-set-texture-coordinates!
       model (reverse (cons v (reverse (model-texture-coordinates model))))))



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


    (define (for-each-mesh model proc)
      (for-each proc (model-meshes model)))


    ;; call op with and replace every face in model.  op should accept mesh
    ;; and face and return face
    (define (operate-on-faces model op)
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


    (define (model-prepend-mesh! model mesh)
      (snow-assert (model? model))
      (snow-assert (mesh? mesh))
      (model-set-meshes! model (cons mesh (model-meshes model))))




    ))
