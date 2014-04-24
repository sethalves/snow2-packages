
(define (main-program)

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


  #t)
