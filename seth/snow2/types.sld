(define-library (seth snow2 types)
  (export make-snow2-repository
          snow2-repository?
          snow2-repository-siblings set-snow2-repository-siblings!
          snow2-repository-packages set-snow2-repository-packages!
          snow2-repository-local set-snow2-repository-local!
          snow2-repository-url set-snow2-repository-url!
          make-snow2-sibling
          snow2-sibling?
          snow2-sibling-name set-snow2-sibling-name!
          snow2-sibling-url set-snow2-sibling-url!
          snow2-sibling-trust set-snow2-sibling-trust!
          make-snow2-package
          snow2-package?
          snow2-package-name set-snow2-package-name!
          snow2-package-url set-snow2-package-url!
          snow2-package-libraries set-snow2-package-libraries!
          snow2-package-repository set-snow2-package-repository!
          make-snow2-library
          snow2-library?
          snow2-library-name set-snow2-library-name!
          snow2-library-path set-snow2-library-path!
          snow2-library-depends set-snow2-library-depends!
          snow2-library-package set-snow2-library-package!
          ;; get-tag
          get-children-by-type
          get-child-by-type
          get-string-by-type
          get-number-by-type
          get-list-by-type
          get-args-by-type
          get-multi-args-by-type
          )


  (import (scheme base)
          )
  (cond-expand
   (chibi (import (only (srfi 1) filter make-list any fold)))
   (else (import (srfi 1))))

  (begin
    (define-record-type <snow2-repository>
      (make-snow2-repository siblings packages local url)
      snow2-repository?
      (siblings snow2-repository-siblings set-snow2-repository-siblings!)
      (packages snow2-repository-packages set-snow2-repository-packages!)
      (local snow2-repository-local set-snow2-repository-local!)
      (url snow2-repository-url set-snow2-repository-url!))


    (define-record-type <snow2-sibling>
      (make-snow2-sibling name url trust)
      snow2-sibling?
      (name snow2-sibling-name set-snow2-sibling-name!)
      (url snow2-sibling-url set-snow2-sibling-url!)
      (trust snow2-sibling-trust set-snow2-sibling-trust!))


    (define-record-type <snow2-package>
      (make-snow2-package name url libraries repo)
      snow2-package?
      (name snow2-package-name set-snow2-package-name!)
      (url snow2-package-url set-snow2-package-url!)
      (libraries snow2-package-libraries set-snow2-package-libraries!)
      (repo snow2-package-repository set-snow2-package-repository!))


    (define-record-type <snow2-library>
      (make-snow2-library name path depends package)
      snow2-library?
      (name snow2-library-name set-snow2-library-name!)
      (path snow2-library-path set-snow2-library-path!)
      (depends snow2-library-depends set-snow2-library-depends!)
      (package snow2-library-package set-snow2-library-package!))

    (define (get-tag child)
      ;; extract the tag from an element that is assumed to be shaped like:
      ;; '(tag ...)
      (cond ((not (list? child))
             (error "not a list: ~A" child))
            ((null? child)
             (error "list is empty."))
            (else
             (car child))))


    (define (get-children-by-type obj child-type)
      ;; return any child sexps that is a list starting with child-type
      (filter (lambda (child)
                (eq? (get-tag child) child-type))
              (cdr obj)))


    (define (get-child-by-type obj child-type default)
      ;; find a non-optional child with the given tag.  the tag
      ;; is expected to be unique among the children.
      (let ((childs (get-children-by-type obj child-type)))
        (cond ((null? childs)
               (if default
                   default
                   (error "~A has no ~A\n" (get-tag obj) child-type)))
              ((> (length childs) 1)
               (error "~A has more than one ~A\n." obj child-type))
              (else
               (car childs)))))


    (define (get-string-by-type obj child-type default)
      ;; return the string from a child with the form
      ;; '(child-type "...")
      ;; if no such child is found and default isn't #f, return default
      (let ((child (get-child-by-type obj child-type default)))
        (cond ((and (not child) default) default)
              ((and (null? child) default) default)
              ((not child) #f)
              ((null? child) #f)
              ((not (= (length child) 2))
               (error "~A has malformed ~A: ~A\n"
                      (get-tag obj) child-type child))
              (else
               (let ((result (cadr child)))
                 (cond ((not (string? result))
                        (error
                         "value of ~A in ~A isn't a string\n"
                         child-type (get-tag obj)))
                       (else
                        result)))))))


    (define (get-number-by-type obj child-type default)
      ;; return the number from a child with the form
      ;; '(child-type 1.0)
      ;; if no such child is found and default isn't #f, return default
      (let ((child (get-child-by-type obj child-type default)))
        (cond ((and (not child) default) default)
              ((and (null? child) default) default)
              ((not child) #f)
              ((null? child) #f)
              ((not (= (length child) 2))
               (error "~A has malformed ~A: ~A\n"
                      (get-tag obj) child-type child))
              (else
               (let ((result (cadr child)))
                 (cond ((not (number? result))
                        (error
                         "value of ~A in ~A isn't a number\n"
                         child-type (get-tag obj)))
                       (else
                        result)))))))



    (define (get-list-by-type obj child-type default)
      ;; return the list from a child with the form
      ;; '(child-type (x y z))
      ;; if no such child is found and default isn't #f, return default
      (let ((child (get-child-by-type obj child-type default)))
        (cond ((and (not child) default) default)
              ((and (null? child) default) default)
              ((not child) #f)
              ((null? child) #f)
              ((not (= (length child) 2))
               (error "~A has malformed ~A: ~A\n"
                      (get-tag obj) child-type child))
              (else
               (let ((result (cadr child)))
                 (cond ((not (list? result))
                        (error
                         "value of ~A in ~A isn't a list: ~A\n"
                         child-type (get-tag obj) result))
                       (else
                        result)))))))


    (define (get-args-by-type obj child-type default)
      ;; return the list '(x y z) from a child with the form
      ;; '(child-type x y z)
      ;; if no such child is found and default isn't #f, return default
      (let ((child (get-child-by-type obj child-type default)))
        (cond ((and (not child) default) default)
              ((and (null? child) default) default)
              ((not child) #f)
              ((null? child) #f)
              (else
               (cdr child)))))

    (define (get-multi-args-by-type obj child-type default)
      ;; return the appended list '(a b c x y z) from children with the form
      ;; '(child-type a b c)
      ;; '(child-type x y z)
      ;; if no such children are found and default isn't #f, return default
      (let ((childs (get-children-by-type obj child-type)))
        (cond ((and (null? childs) default) default)
              (else
               (fold append '() (map cdr childs))))))




    ))
