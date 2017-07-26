(define-library (seth stl-model)
  (export read-stl-model
          read-stl-model-file
          write-stl-model)
  (import (scheme base)
          (scheme char)
          (scheme file)
          (scheme write)
          (scheme cxr)
          (scheme process-context)
          ;; (srfi 13)
          (srfi 29)
          (srfi 69)
          (snow assert)
          (seth port-extras)
          (snow input-parse)
          (seth cout)
          (seth strings)
          (seth math-3d)
          (seth model-3d))
  (cond-expand
   (chicken (import (extras)))
   (else))

  (begin

    ;; http://en.wikipedia.org/wiki/STL_(file_format)

    (define (parse-stl f model)
      ;; this parser was made to read the output of openscad, and will probably
      ;; fail on an stl file from any other source.

      (let loop ((state 'start)
                 (mesh #f)
                 (vertexes '())
                 (normal 'unset))

        (case state

          ((start)
           (let* ((solid-str (read-word f))
                  (model-name-str (read-word f)))
             (if (equal? (string-downcase solid-str) "solid")
                 (loop 'read-triangle (make-mesh model-name-str '()) '() normal)
                 (error "stl file didn't start with \"solid\":" solid-str))))

          ((read-triangle)
           (let ((facet-str (string-downcase (read-word f))))
             (cond ((equal? facet-str "facet")
                    (let ((words (map string-downcase (read-words 6 f))))
                      (if (and (equal? (list-ref words 0) "normal")
                               (equal? (list-ref words 4) "outer")
                               (equal? (list-ref words 5) "loop"))
                          (let ((new-normal (vector (list-ref words 1)
                                                    (list-ref words 2)
                                                    (list-ref words 3))))
                            (loop 'read-vertex mesh '() new-normal))
                          (error "triangle is malformed"))))
                   ((equal? facet-str "endsolid")
                    ;; all done.
                    (read-word f) ;; discard trailing model name
                    (model-prepend-mesh! model mesh)
                    model)
                   (else
                    (error "didn't see \"facet\" or \"endsolid\"")))))

          ((read-vertex)
           (let ((vertex-str (string-downcase (read-word f))))
             (cond
              ((equal? vertex-str "vertex")
               (let ((coord-strs (read-words 3 f)))
                 (if (= (length coord-strs) 3)
                     (loop 'read-vertex mesh
                           (cons
                            (make-vertex (list->vector coord-strs) (vector 'unset 'unset 'unset))
                            ;; (vector (list-ref coord-strs 0)
                            ;;         (list-ref coord-strs 1)
                            ;;         (list-ref coord-strs 2))

                                 vertexes)
                           normal)
                     (error "vertex is malformed."))))
              ((equal? vertex-str "endloop")
               (let ((endfacet-str (string-downcase (read-word f))))
                 (cond ((equal? endfacet-str "endfacet")
                        (let ((face (make-face
                                     model
                                     (vector-map
                                      (lambda (vertex)
                                        (make-face-corner
                                         (model-append-vertex! model vertex)
                                         'unset
                                         (model-append-normal! model normal)))
                                      (list->vector vertexes))
                                     #f)))
                          (if (not (face-is-degenerate? model face))
                              (mesh-append-face! model mesh face))
                          (loop 'read-triangle mesh '() 'unset)))
                       (else
                        (error "didn't see \"endfacet\"")))))
              (else
               (error "didn't see \"vertex\" or \"endloop\"")))))

          (else
           (error "stl parser is broken.")))))


    (define (read-stl-model inport . maybe-model)
      (snow-assert (input-port? inport))

      (let* ((model (if (null? maybe-model)
                        (make-empty-model)
                        (car maybe-model)))
             (vertex-index-start
              (coordinates-length (model-vertices model)))
             (texture-index-start
              (coordinates-length (model-texture-coordinates model)))
             (normal-index-start
              (coordinates-length (model-normals model))))
        (snow-assert (model? model))
        (parse-stl inport model)
        model))


    (define (read-stl-model-file input-file-name . maybe-model)
      (snow-assert (string? input-file-name))
      (let ((model (if (null? maybe-model)
                       (make-empty-model)
                       (car maybe-model))))
        (snow-assert (model? model))
        (read-stl-model (open-input-file input-file-name) model)))


    (define (write-stl-model model port)
      (snow-assert (model? model))
      (snow-assert (output-port? port))
      ;; ...
      (error "write write-stl-model")
      )

    ))
