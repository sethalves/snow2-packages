(define-library (seth xml tests)
  (export run-tests)
  (import (scheme base)
          (scheme write)
          (srfi 1)
          (except (srfi 13)
                  string-copy string-map string-for-each
                  string-fill! string-copy! string->list
                  string-upcase string-downcase)
          (scheme char)
          (scheme cxr)
          (snow extio)
          (snow assert)
          (seth xml ssax)
          (seth xml sxpath)
          (seth xml sxml-serializer))
  (begin
    (define (run-tests)

      (let* ((xml (string-append
                   "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n"
                   "<D:propfind xmlns:D=\"DAV:\">\n"
                   "    <D:prop>\n"
                   "        <D:resourcetype/>\n"
                   "    </D:prop>\n"
                   "</D:propfind>\n"))
             (xml-port (open-input-string xml)))

        (display (ssax:xml->sxml xml-port '()))
        (newline))


      (display

       ((sxpath '((chapter ((equal? (title "Introduction"))))))
        '(text  (chapter (title "Introduction"))  (chapter "No title for this chapter")  (chapter (title "Conclusion"))))

       )

      ;; => ((chapter (title "Introduction")))

      (newline)



      (display
       (serialize-sxml
        '(*TOP* (@ (*NAMESPACES* (atom "http://www.w3.org/2005/Atom")))
                (atom:feed))
        'ns-prefixes '((atom . "http://www.w3.org/2005/Atom"))))
      (newline)

      (display
       (serialize-sxml
        '(*TOP* (@ (*NAMESPACES* (atom "http://www.w3.org/2005/Atom")))
                (atom:feed))
        'ns-prefixes '((*default* . "http://www.w3.org/2005/Atom"))))
      (newline)

      (display
       (serialize-sxml
        '(*TOP* (@ (*NAMESPACES* (atom "http://www.w3.org/2005/Atom")))
                (atom:feed (atom:id) (orphan)))
        'ns-prefixes '((*default* . "http://www.w3.org/2005/Atom"))))
      (newline)

      (display
       (serialize-sxml
        '(*TOP* (@ (*NAMESPACES* (atom "http://www.w3.org/2005/Atom")
                                 (xhtml "http://www.w3.org/1999/xhtml")))
                (atom:feed (atom:entry
                            (atom:content (@ (type "xhtml"))
                                          (xhtml:div
                                           (xhtml:p "I'm invincible!"))))))
        'ns-prefixes '((*default* . "http://www.w3.org/2005/Atom")
                       (*default* . "http://www.w3.org/1999/xhtml"))))
      (newline)


      (display
       (serialize-sxml
        '((*TOP* (http://foo:one (http://bar:two))
                 (http://bar:three)))
        'ns-prefixes '((BAZ . "http://foo") (BAZ . "http://bar"))))
      (newline)


      (display
       (serialize-sxml
        '((*TOP* (http://foo:one (http://bar:two))
                 (http://bar:three)))
        'ns-prefixes '((BAZ . "http://foo") (BAZ . "http://bar"))
        'allow-prefix-redeclarations #f))
      (newline)


      (display
       (serialize-sxml
        '(*TOP* (http://foo:one
                 (http://bar:two
                  (http://bar:three)
                  (http://foo:four)
                  (five (six (http://foo:seven))))))
        'ns-prefixes '((*default* . "http://foo") (*default* . "http://bar"))))
      (newline)

      #t)))
