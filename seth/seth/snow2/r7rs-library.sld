(define-library (seth snow2 r7rs-library)
  (export r7rs-get-library-imports
          r7rs-get-exports-from-imports
          )
  (import (scheme base)
          (scheme cxr)
          (scheme read)
          (scheme write)
          (scheme file)
          (snow filesys)
          (seth srfi-69-hash-tables)
          (seth snow2 types)
          (seth snow2 utils)
          )

  (cond-expand
   (chibi (import (only (srfi 1) filter)))
   (else (import (srfi 1))))

  (begin

    (define (r7rs-explode-cond-expand r7rs-lib)
      (let loop ((r7rs-lib r7rs-lib)
                 (result '()))
        (cond ((null? r7rs-lib) result)
              (else
               (let ((term (car r7rs-lib)))
                 (cond ((and (pair? term)
                             (eq? (car term) 'cond-expand))
                        (let* ((ce-terms (cdr term))
                               (childs (map cdr ce-terms))
                               (childs-flat (apply append childs)))
                          (loop (cdr r7rs-lib) (append result childs-flat))))
                       (else
                        (loop (cdr r7rs-lib)
                              (append result (list term))))))))))


    (define (r7rs-drop-body r7rs-lib)
      (filter
       (lambda (term)
         (not (and (pair? term) (eq? (car term) 'begin))))
       r7rs-lib))


    (define (r7rs-extract-im/export r7rs-lib type)
      (let loop ((r7rs-lib r7rs-lib)
                 (result '()))
        (cond ((null? r7rs-lib) result)
              (else
               (let ((term (car r7rs-lib)))
                 (cond ((and (pair? term) (eq? (car term) type))
                        (let ((childs (cdr term)))
                          (loop (cdr r7rs-lib) (append result childs))))
                       (else
                        (loop (cdr r7rs-lib) result))))))))

    (define (uniq lst)
      (cond ((null? lst) lst)
            ((member (car lst) (cdr lst)) (uniq (cdr lst)))
            (else (cons (car lst) (uniq (cdr lst))))))


    (define (r7rs-filter-known-imports r7rs-imports)
      (filter
       (lambda (r7rs-import)
         (cond ((and (pair? r7rs-import)
                     (memq (car r7rs-import)
                           '(scheme scheme chibi r7rs gauche sagittarius
                                    ports tcp rnrs use openssl udp posix
                                    srfi chicken ssax sxml sxpath txpath
                                    sxpath-lolevel text md5 rfc math sha1 sha2
                                    util memcached matchable match
                                    extras http-client uri-generic intarweb
                                    message-digest file z3 base64 hmac
                                    binary input-parse

                                    srfi-27 srfi-95
                                    ))) #f)
               (else #t)))
       r7rs-imports))


    (define (r7rs-import-set->libs r7rs-import)
      (cond ((not (pair? r7rs-import))
             (display "Warning: unexpected import form: ")
             (write r7rs-import)
             (newline)
             r7rs-import)
            ((eq? (car r7rs-import) 'only)
             (r7rs-import-set->libs (cadr r7rs-import)))
            ((eq? (car r7rs-import) 'prefix)
             (r7rs-import-set->libs (cadr r7rs-import)))
            (else r7rs-import)))



    (define (r7rs-get-library-imports filename)
      ;; (display filename)
      ;; (newline)

      (let* ((p (open-input-file filename))
             (r7rs-lib (read p))
             (r7rs-no-begin (r7rs-drop-body r7rs-lib))
             (r7rs-sans-ce (r7rs-explode-cond-expand r7rs-no-begin))
             (r7rs-imports-all (r7rs-extract-im/export r7rs-sans-ce 'import))
             (r7rs-imports-clean (map r7rs-import-set->libs r7rs-imports-all))
             ;; (r7rs-imports-clean
             ;;  (map (lambda (r7rs-import)
             ;;         (cond ((not (pair? r7rs-import))
             ;;                (display "Warning: unexpected import form: ")
             ;;                (write r7rs-import)
             ;;                (newline)
             ;;                r7rs-import)
             ;;               ((eq? (car r7rs-import) 'only)
             ;;                (cadr r7rs-import))
             ;;               ((eq? (car r7rs-import) 'prefix)
             ;;                (cadr r7rs-import))
             ;;               (else r7rs-import)))
             ;;       r7rs-imports-all))
             (r7rs-imports
              (r7rs-filter-known-imports (uniq r7rs-imports-clean)))
             )
        (close-input-port p)

        ;; (snow-pretty-print r7rs-no-begin)
        ;; (newline)
        ;; (snow-pretty-print r7rs-sans-ce)
        ;; (newline)
        ;; (newline)
        ;; (snow-pretty-print r7rs-imports)
        ;; (newline)
        ;; (snow-pretty-print r7rs-imports)
        ;; (newline)

        r7rs-imports))


    (define (hash-table-cons! ht key value)
      (cond ((hash-table-exists? ht key)
             (let ((previous (hash-table-ref ht key)))
               (hash-table-set! ht key (cons value previous))))
            (else
             (hash-table-set! ht key (list value)))))


    (define (r7rs-get-library-exports filename)
      ;; (display filename)
      ;; (newline)

      (let* ((p (open-input-file filename))
             (r7rs-lib (read p))
             (r7rs-no-begin (r7rs-drop-body r7rs-lib))
             (r7rs-exports (r7rs-extract-im/export r7rs-no-begin 'export)))
        (close-input-port p)
        r7rs-exports))


    (define (r7rs-get-exports-from-imports-set repositories import-set)
      (cond ((not (list? import-set))
             (error "import-set isn't a list"))
            ((null? import-set)
             (error "import-set is empty"))
            ((eq? (car import-set) 'only)
             (let ((lib (car (r7rs-import-set->libs (list (cadr import-set))))))
               (values lib (cddr import-set))))
            ((eq? (car import-set) 'prefix)
             (let ((prefix (symbol->string (caddr import-set))))
               (let-values (((sub-lib sub-identifiers)
                             (r7rs-get-exports-from-imports-set
                              repositories (cadr import-set))))
                 (values sub-lib
                         (map (lambda (identifier)
                                (string->symbol
                                 (string-append
                                  prefix (symbol->string identifier))))
                              sub-identifiers)))))
            ((eq? (car import-set) 'prefix)
             (error "write this"))
            ((eq? (car import-set) 'rename)
             (error "write this"))
            (else
             (let* ((local-repos (filter snow2-repository-local repositories))
                    (libs (find-libraries-by-name local-repos import-set))
                    (libs-len (length libs)))
               (cond ((= libs-len 0)
                      (display "library ")
                      (write import-set)
                      (display " not found in a local repository.\n")
                      (values #f '()))
                     ((> libs-len 1)
                      (display "library ")
                      (write import-set)
                      (display " found in more than one repository.\n")
                      (values #f '()))
                     (else
                      (let* ((lib (car libs))
                             (lib-path (local-repository->in-fs-lib-path
                                        (car local-repos) lib)))
                        (values
                         import-set
                         (r7rs-get-library-exports
                          (snow-combine-filename-parts lib-path))))))))))





    (define (r7rs-get-exports-from-imports repositories import-decl)
      ;; given an import declaration, figure out the names of
      ;; the libraries, see if we can find these libraries in
      ;; local repositories and return a hashtable with library
      ;; names as keys and export-lists as values.
      (cond ((not (list? import-decl))
             (error "r7rs-get-exports-from-imports import-decl isn't a list"))
            ((null? import-decl)
             (error "r7rs-get-exports-from-imports import-decl is empty"))
            ((not (eq? (car import-decl) 'import))
             (error "r7rs-get-exports-from-imports no (import ...)"))
            (else
             (let ((result (make-hash-table)))
               (for-each
                (lambda (import-set)
                  (let-values (((lib identifiers)
                                (r7rs-get-exports-from-imports-set
                                 repositories import-set)))
                    (if lib
                        (for-each
                         (lambda (identifier)
                           (hash-table-cons! result lib identifier))
                         identifiers))))
                (cdr import-decl))
               result))))

    ))
