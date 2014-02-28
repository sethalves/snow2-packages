

(define-syntax test-group
  (syntax-rules ()
    ((test-group name test-body ...)
     (begin
       (display name)
       (newline)
       (display (make-string (string-length name) #\-))
       (newline)
       test-body ...))))


(define (fancy-equal? a b)
  (cond ((and (uri-reference? a) (uri-reference? b)) (uri-equal? a b))
        ((and (authority? a) (authority? b)) (uri-auth-equal? a b))
        (else (equal? a b))))


(define-syntax test
  (syntax-rules ()
    ((test name a b)
     (cond ((fancy-equal? a b) #t)
           (else
            (newline)
            (display name)
            (display " failed\n")
            (display a)
            (newline)
            (display b)
            (newline)
            )))
    ((test a b)
     (cond ((fancy-equal? a b) #t)
           (else
            (display "test failed\n"))))))


(define (test-assert name a)
  (cond (a #t)
        (else
         (display name)
         (display " failed\n"))))



(define-syntax test-error
  (syntax-rules ()
    ((test-error name test-body ...)
     (begin
       (snow-with-exception-catcher
        (lambda (exn) #t)
        (lambda ()
          (begin test-body ...)
          (snow-assert #f)))))))


(define (test-end name)
  (display "end of test ")
  (display name)
  (newline))


(cond-expand
 ((or gauche sagittarius)
  (define sprintf format)
  (define (conc . args)
    (apply string-append (map display-to-string args))))
 (else))


(define  path-cases
  '(;; test cases from Python URI implementation
    ("foo:xyz" "bar:abc" "bar:abc")
    ("http://example/x/y/z" "http://example/x/abc" "../abc")
    ("http://example2/x/y/z" "http://example/x/abc" "//example/x/abc")
    ("http://ex/x/y/z" "http://ex/x/r" "../r")

    ("http://ex/x/y"  "http://ex/x/q/r" "./q/r")
    ("http://ex/x/y"  "http://ex/x/q/r#s" "./q/r#s")
    ("http://ex/x/y"  "http://ex/x/q/r#s/t" "./q/r#s/t")
    ("http://ex/x/y"  "ftp://ex/x/q/r" "ftp://ex/x/q/r")
    ("http://ex/x/y"  "http://ex/x/y"   "")
    ("http://ex/x/y/" "http://ex/x/y/"  "")
    ("http://ex/x/y/pdq" "http://ex/x/y/pdq" "")
    ("http://ex/x/y/" "http://ex/x/y/z/" "./z/")
    ("file:/swap/test/animal.rdf" "file:/swap/test/animal.rdf#Animal" "#Animal")
    ("file:/e/x/y/z" "file:/e/x/abc" "../abc")
    ("file:/example2/x/y/z" "file:/example/x/abc" "/example/x/abc")   
    ("file:/ex/x/y/z" "file:/ex/x/r" "../r")
    ("file:/ex/x/y/z" "file:/r" "/r")        
    ("file:/ex/x/y" "file:/ex/x/q/r" "./q/r")
    ("file:/ex/x/y" "file:/ex/x/q/r#s" "./q/r#s")
    ("file:/ex/x/y" "file:/ex/x/q/r#" "./q/r#")
    ("file:/ex/x/y" "file:/ex/x/q/r#s/t" "./q/r#s/t")
    ("file:/ex/x/y" "ftp://ex/x/q/r" "ftp://ex/x/q/r")
    ("file:/ex/x/y" "file:/ex/x/y" "")
    ("file:/ex/x/y/" "file:/ex/x/y/" "")
    ("file:/ex/x/y/pdq" "file:/ex/x/y/pdq" "")
    ("file:/ex/x/y/" "file:/ex/x/y/z/" "./z/")
    ("file:/devel/WWW/2000/10/swap/test/reluri-1.n3" "file://meetings.example.com/cal#m1" 
     "//meetings.example.com/cal#m1")
    ("file:/home/connolly/w3ccvs/WWW/2000/10/swap/test/reluri-1.n3" "file://meetings.example.com/cal#m1" 
     "//meetings.example.com/cal#m1")
    ("file:/some/dir/foo" "file:/some/dir/#blort" "./#blort")
    ("file:/some/dir/foo" "file:/some/dir/#" "./#")
    ;; From Graham Klyne Thu 20 Feb 2003 18:08:17 +0000
    ("http://example/x/y%2Fz"  "http://example/x/abc"     "./abc")
    ("http://example/x/y/z"    "http://example/x%2Fabc"   "/x%2Fabc")
    ("http://example/x/y%2Fz"  "http://example/x%2Fabc"   "/x%2Fabc")
    ("http://example/x%2Fy/z"  "http://example/x%2Fy/abc" "./abc")
    ;; Ryan Lee
    ("http://example/x/abc.efg" "http://example/x/" "./")
    ))

(define base "http://a/b/c/d;p?q")

(define rfc-cases
  `(;; Examples from section 5.2.4
    ("/a/b/c/" "./../../g" "/a/g")
    ("/a/b/c/xyz" "./../../g" "/a/g") ; Input could've had a trailing component
    ("mid/content=5/" "../6" "mid/6")
    ("mid/content=5/7" "../6" "mid/6") ; Same here

    ;; "Normal examples", section 5.4.1
    (,base "g:h" "g:h")
    (,base "g" "http://a/b/c/g")
    (,base "./g" "http://a/b/c/g")
    (,base "g/" "http://a/b/c/g/")
    (,base "/g" "http://a/g")
    (,base "//g" "http://g")
    (,base "?y" "http://a/b/c/?y") 
    (,base "g?y" "http://a/b/c/g?y")
    (,base "#s" "http://a/b/c/d;p?q#s") 
    (,base "g#s" "http://a/b/c/g#s")
    (,base "g?y#s" "http://a/b/c/g?y#s")
    (,base ";x" "http://a/b/c/;x")
    (,base "g;x" "http://a/b/c/g;x")
    (,base "g;x?y#s" "http://a/b/c/g;x?y#s")
    (,base "."  "http://a/b/c/")
    (,base "./" "http://a/b/c/")
    (,base ".." "http://a/b/")
    (,base "../" "http://a/b/")
    (,base "../g" "http://a/b/g")
    (,base "../.." "http://a/")
    (,base "../../" "http://a/")
    (,base "../../g" "http://a/g")
    
    ;; "Abnormal examples", section 5.4.2
    (,base "" ,base)
    (,base "../../../g" "http://a/g") 
    (,base "../../../../g" "http://a/g")
    (,base "../../../.." "http://a/") ; Is this correct? Or http://a ?
    (,base "../../../../" "http://a/")
    (,base "/./g" "http://a/g")
    (,base "/../g" "http://a/g")
    (,base "g.." "http://a/b/c/g..")
    (,base "..g" "http://a/b/c/..g")
    
    (,base "./../g" "http://a/b/g")
    (,base "./g/." "http://a/b/c/g/") 
    (,base "g/./h" "http://a/b/c/g/h") 
    (,base "g/../h" "http://a/b/c/h")
    (,base "g;x=1/./y" "http://a/b/c/g;x=1/y") 
    (,base "g;x=1/../y" "http://a/b/c/y")  
    
    (,base "g?y/./x" "http://a/b/c/g?y/./x")
    (,base "g?y/../x" "http://a/b/c/g?y/../x")
    (,base "g#s/./x" "http://a/b/c/g#s/./x")
    (,base "g#s/../x" "http://a/b/c/g#s/../x")
    ))

(define extra-cases
  `(("?a=b&c=d" "" "?a=b&c=d")
    (,base "" "http://a/b/c/d;p?q")
    ("" ,base "http://a/b/c/d;p?q")
    (,base "http:" "http:")
    (,base "..%2f" "http://a/b/c/..%2f")
    ;; Assume an empty uri-reference is identical to "."
    ("http://a/b/c/d/" "" "http://a/b/c/d/")
    ("http://a/b/c/d" "" "http://a/b/c/d")
    ("http://a/b/c/d/" ".." "http://a/b/c/")
    ("http://a/b/c/d/" "../e" "http://a/b/c/e")
    ("http://a/b/c/d/" "../e/" "http://a/b/c/e/")
    ("http://a/b//c///d///" "../.." "http://a/b//c///d/")
    ("http://a/b/c/d/" "..//x" "http://a/b/c//x")
    ("http://a" "b" "http://a/b") ; RFC3986, section 5.2.3, first bullet point
    
    ;; Empty segments are segments nonetheless, so should be treated as such
    ;; [http://bugs.call-cc.org/ticket/396]
    ("http://a//b//c" "../../../.." "http://a/")
    ))

(define reverse-extra-cases
  `((,base ,base "")
    (,base "http://a/b/c/e" "./e")
    (,base "http://a/b/c/" "./")  ;; Not sure if the trailing slash belongs here
    (,base "http://a/b/e" "../e")
    (,base "http://a/b/c" "../c") ;; Slightly weird: dir in base, file in target
    (,base "http://a/b/" "../")
    (,base "http://a/" "/") ;; or "../../"
    (,base "http://a" "//a") ; No relative representation possible
    (,base "http://b" "//b")
    (,base "http://b/" "//b/")
    (,base "http://b/c" "//b/c")
    (,base "ftp://a/b/c/d;p?q" "ftp://a/b/c/d;p?q")
    (,base "ftp://x/y/z;a?b" "ftp://x/y/z;a?b")))


(define encode/decode-cases
  '(("foo?bar" "foo%3Fbar")
    ("foo&bar" "foo%26bar")
    ("foo%20bar" "foo%2520bar")
    ;; ("foo\x00bar\n" "foo%00bar%0A") ;; sagittarius hates this
    ))


(define normalize-case-cases
  '(("http://exa%2fmple/FOO%2fbar" "http://exa%2Fmple/FOO%2Fbar")
    ("http://EXA%2fMPLE/FOO%2fbar" "http://exa%2Fmple/FOO%2Fbar")
    ("HTTP://example/" "http://example/")
    ("http://user:PASS@example/FOO%2fbar" "http://user:PASS@example/FOO%2Fbar")
    ("http://uS%2fer:PA%2fSS@example/FOO%2fbar" "http://uS%2Fer:PA%2FSS@example/FOO%2Fbar")
    ("HTTP://example/?mooH=MUMBLe%2f" "http://example/?mooH=MUMBLe%2F")
    ("http://example/#baR%2f" "http://example/#baR%2F")))


(define internal-representation-cases
  `(("scheme" ,uri-scheme
     ;; pct-encoding not allowed in scheme
     ("http.:" http.)
     ("http+:" http+)
     ("http-:" http-)
     ("HTTP:" HTTP)
     ("" #f)
     ("/foo" #f))
    ("host" ,uri-host
     ("//:123" "")
     ;; Thanks to Roel van der Hoorn for finding this one
     ("//%20/" "%20"))
    ("port" ,uri-port
     ("//host:123" 123))
    ("username" ,uri-username
     ("//foo" #f)
     ("//@" "")
     ("//foo@" "foo")
     ("//foo:bar@" "foo")
     ("//foo:bar:qux@" "foo")
     ("//foo%20bar@" "foo%20bar")
     ("//foo%3Abar:qux@" "foo%3Abar") ;; %3A = ':'
     ("//foo%2Ebar@" "foo.bar" "//foo.bar@"))
    ("password ",uri-password
     ("//foo" #f)
     ("//@" #f)
     ("//foo@" #f)
     ("//foo:bar@" "bar")
     ("//foo:bar:qux@" "bar:qux")
     ("//foo:bar%20qux@" "bar%20qux")
     ("//foo:bar%2Equx@" "bar.qux" "//foo:bar.qux@"))
    ("path" ,uri-path
     ("//foo" ())   ; Can path ever be #f?
     ("foo%20bar" ("foo%20bar"))
     ("foo%2Fbar" ("foo/bar"))
     ("foo%2ebar" ("foo.bar") "foo.bar")
     ("foo/bar%2Fqux" ("foo" "bar/qux"))
     ("foo/" ("foo" ""))
     
     ;; Empty path components preserved?  [http://bugs.call-cc.org/ticket/396]
     ("//foo//bar" (/ "" "bar"))
     ("//foo///bar" (/ "" "" "bar"))
     ("/foo//bar" (/ "foo" "" "bar"))
     ("/foo///bar" (/ "foo" "" "" "bar"))
     ("foo//bar" ("foo" "" "bar"))
     ("foo///bar" ("foo" "" "" "bar"))
     ("foo//" ("foo" "" ""))
     ("foo///" ("foo" "" "" ""))
     
     ("foo/bar:qux" ("foo" "bar:qux"))
     ("/foo%2Fbar" (/ "foo/bar"))
     ("/foo/" (/ "foo" ""))
     ("/" (/ ""))
     ("/?foo" (/ ""))
     ("/#foo" (/ ""))
     ("/foo:bar" (/ "foo:bar")))
    ("query ",uri-query
     ("//" #f)
     ("/?foo" "foo")
     ("?foo" "foo")
     ("?foo?bar" "foo?bar")
     ("?foo/bar" "foo/bar")
     ("?foo%3Fbar" "foo%3Fbar")
     ("?foo%2Ebar" "foo.bar" "?foo.bar"))
    ("fragment" ,uri-fragment
     ("?foo" #f)
     ("#bar" "bar")
     ("/#bar" "bar")
     ("?foo#bar" "bar")
     ("/?foo#bar" "bar")
     ("#foo?bar" "foo?bar")
     ("#foo/bar" "foo/bar")
     ("#foo%3Fbar" "foo%3Fbar")
     ("#foo%2Ebar" "foo.bar" "#foo.bar"))))



;; I wonder if there's a term for this :)
(define non-relative-non-absolute-uri-references
  '("http://foo#frag"
    "http://foo?a=b#frag"
    "http://foo/bar#frag"
    "http://foo/bar?a=b#frag"))

(define absolute-uris
  '("http://foo"
    "http://foo?a=b"
    "http://foo/bar"
    "http://foo/bar?a=b"))

(define relative-refs
  `(""
    "bar"
    "bar?a=b"
    "bar#frag"
    "bar?a=b#frag"
    "/"
    "/bar"
    "/bar?a=b"
    "/bar#frag"
    "/bar?a=b#frag"
    "//foo"
    "//foo?a=b"
    "//foo#frag"
    "//foo?a=b#frag"
    "//foo/bar"
    "//foo/bar?a=b"
    "//foo/bar#frag"
    "//foo/bar?a=b#frag"))


(define absolute-paths
  '("/"
    "/foo"
    "//foo/"
    "http://foo/bar"
    "http://foo/"
    "http://foo/#qux"
    "http://foo/?bar=qux"))

(define relative-paths
  '(""
    "http://foo"
    "//foo"
    "http://foo#bar"
    "http://foo?bar=qux"))


;; Uri-references not allowed by the BNF
(define invalid-refs
  `(":" ;; This should be encoded to %3a, since an empty scheme is not allowed
    "1:" ;; scheme starts with ALPHA
    "//host:abc"  ;; port must be a number
    " " ;; make sure that any URIs with space < > " are rejected
    "foo " 
    " foo " 
    "<foo" 
    "foo>" 
    "<foo>" 
    "\"foo\"" 
    "%" ;; % must be followed by two hex digits
    "abc%xyz" 
    "http://foo.com/bar?a=b|c" ;; | must be encoded as %7C
    ))



;; Examples URIs from RFC 4151 The 'tag' URI scheme 
;;
;; Tag URIs always contain a colon, so uri->string will prefix their
;; paths by ./ as per section 4.2 in RFC 3986
(define rfc4151-refs
  `(
    ("tag:timothy@hpl.hp.com,2001:web/externalHome"
     "tag:./timothy@hpl.hp.com,2001:web/externalHome")
    ("tag:sandro@w3.org,2004-05:Sandro"
     "tag:./sandro@w3.org,2004-05:Sandro"
     )
    ("tag:my-ids.com,2001-09-15:TimKindberg:presentations:UBath2004-05-19"
     "tag:./my-ids.com,2001-09-15:TimKindberg:presentations:UBath2004-05-19"
     )
    ("tag:blogger.com,1999:blog-555" 
     "tag:./blogger.com,1999:blog-555"
     )
    ("tag:yaml.org,2002:int" 
     "tag:./yaml.org,2002:int"
     )
    ))



;; Examples URIs from RFC 4452 The 'info' URI scheme 
;;
(define rfc4452-refs
  `(
    ("info:ddc/22/eng//004.678"
     "info:ddc/22/eng//004.678")
    ("info:lccn/2002022641"
     "info:lccn/2002022641"
     )
    ("info:sici/0363-0277(19950315)120:5%3C%3E1.0.TX;2-V"
     "info:sici/0363-0277(19950315)120:5%3C%3E1.0.TX;2-V")
    ("info:bibcode/2003Icar..163..263Z"
     "info:bibcode/2003Icar..163..263Z")
    ))



;; Examples URIs from RFC 5724 URI scheme for global system for mobile communication
;;
(define rfc5724-refs
  `(
    ("sms:+15105550101"
     "sms:+15105550101")
    ("sms:+15105550101,+15105550102"
     "sms:+15105550101,+15105550102")
    ("sms:+15105550101?body=hello%20there"
     "sms:+15105550101?body=hello%20there"
     )
    ))



;; Examples URIs from RFC 4501 DNS URIs
;;
(define rfc4501-refs
  `(
    ("dns:www.example.org.?clAsS=IN;tYpE=A"
     "dns:www.example.org.?clAsS=IN;tYpE=A")
    ("dns://192.168.1.1/ftp.example.org?type=A"
     "dns://192.168.1.1/ftp.example.org?type=A")
    ("dns:world%20wide%20web.example%5c.domain.org?TYPE=TXT"
     "dns:world%20wide%20web.example%5c.domain.org?TYPE=TXT")
    ("dns://fw.example.org/*.%20%00.example?type=TXT"
     "dns://fw.example.org/*.%20%00.example?type=TXT")
    ))


;; Examples URIs from RFC 5122
;;
(define rfc5122-refs
  `(("xmpp:nasty!%23$%25()*+,-.;=%3F%5B%5C%5D%5E_%60%7B%7C%7D~node@example.com"
     ("nasty!#$%()*+,-.;=?[\\]^_`{|}~node@example.com")) ;; the decoded path component
    ("xmpp:node@example.com/repulsive%20!%23%22$%25&'()*+,-.%2F:;%3C=%3E%3F%40%5B%5C%5D%5E_%60%7B%7C%7D~resource"
     ("node@example.com" "repulsive !#\"$%&'()*+,-./:;<=>?@[\\]^_`{|}~resource")) ;; the decoded path component
    ))
    


(define make-cases
  `(("http://example.com:123/foo/bar?a=b;c=d#location"
     scheme http host "example.com" port 123 path (/ "foo" "bar")
     query "a=b;c=d" fragment "location")
    ("//example.com:123/foo/bar?a=b;c=d#location"
     host "example.com" port 123 path (/ "foo" "bar")
     query "a=b;c=d" fragment "location")
    ("/foo/bar?a=b;c=d#location"
     port 123 path (/ "foo" "bar") query "a=b;c=d" fragment "location")
    ("foo/bar?a=b;c=d#location"
     path ("foo" "bar") query "a=b;c=d" fragment "location")
    ("/?a=b;c=d#location"
     path (/ "") query "a=b;c=d" fragment "location")
    ("?a=b;c=d#location"
     query "a=b;c=d" fragment "location")
    ("#location"
     fragment "location")
    ("//example.com?a=b;c=d"
     host "example.com" query "a=b;c=d")
    ("//example.com#location"
     host "example.com" fragment "location")
    ("/"
     path (/ ""))
    ("/"
     path (/))                         ; Not sure if this works by accident
    (""
     path ())
    ("")))


(define (main-program)

  ;; (display (uri-reference "https://www.hungry.com/~alves"))
  ;; (newline)
  ;; (write (uri->string
  ;;           (apply
  ;;            make-uri
  ;;            (cdr
  ;;             `("http://example.com:123/foo/bar?a=b;c=d#location"
  ;;               scheme http host "example.com" port 123 path (/ "foo" "bar")
  ;;               query "a=b;c=d" fragment "location")))))
  ;; (newline)
  ;; (exit 0)


(test-group "uri test"
  (for-each (lambda (p)
              (let ((ubase (uri-reference (first p)))
                    (urabs  (uri-reference (second p)))
                    (uex   (uri-reference (third p))))
                (let* ((from (uri-relative-from urabs ubase))
                       (to    (uri-relative-to from ubase)))
                  (test (apply sprintf "~s * ~s -> ~s" p) uex from)
                  (test (apply sprintf "~s * ~s -> ~s" p) urabs to)
                  (unless (uri-fragment urabs)
                    (let ((uabs  (absolute-uri (second p))))
                      (test (sprintf "~s = ~s" uabs urabs) urabs uabs)))
                  ))
              (for-each
               (lambda (s)
                 (test (sprintf "~s = ~s" s (uri->string (uri-reference s)))
                       s (uri->string (uri-reference s))))
               p))
            path-cases))

(test-group "rfc test"
  (for-each (lambda (p)
              (let ((ubase (uri-reference (first p)))
                    (urabs  (uri-reference (second p)))
                    (uex   (uri-reference (third p))))
                (let* ((to    (uri-relative-to urabs ubase)))
                  (test (apply sprintf "~s * ~s -> ~s" p) uex to)
                  ))
              (for-each
               (lambda (s)
                 (test (sprintf "~s = ~s" s (uri->string (uri-reference s)))
                       s (uri->string (uri-reference s))))
               p))
            rfc-cases))

(test-group "extra-test"
  (for-each (lambda (p)
              (let ((ubase (uri-reference (first p)))
                    (urabs  (uri-reference (second p)))
                    (uex   (uri-reference (third p))))
                (let* ((to    (uri-relative-to urabs ubase)))
                  (test (apply sprintf "~s * ~s -> ~s" p) uex to)
                  )))
            extra-cases))

(test-group "reverse-extra-test"
  (for-each (lambda (p)
              (let ((ubase (uri-reference (first p)))
                    (urabs  (uri-reference (second p)))
                    (uex   (uri-reference (third p))))
                (let* ((to    (uri-relative-from urabs ubase)))
                  (test (apply sprintf "~s * ~s -> ~s" p) uex to)
                  )))
            reverse-extra-cases))


(test-group "uri-encode-string test"
  (for-each (lambda (p)
              (let ((expected (second p))
                    (encoded (uri-encode-string (first p))))
                  (test (sprintf "~s -> ~s" (first p) expected) expected encoded)))
            encode/decode-cases))

(test-group "uri-decode-string test"
  (for-each (lambda (p)
              (let ((expected (first p))
                    (decoded (uri-decode-string (second p))))
                  (test (sprintf "~s -> ~s" (second p) expected) expected decoded)))
            encode/decode-cases))


(test-group "normalize-case test"
  (for-each (lambda (p)
              (let ((case-normalized (uri-normalize-case (uri-reference (first p))))
                    (expected (second p)))
                  (test (sprintf "~s -> ~s" (first p) (second p)) expected (uri->string case-normalized (lambda (user pass) (conc user ":" pass))))))
            normalize-case-cases))


(test-group "internal representations"
  (for-each (lambda (p)
              (test-group (car p)
               (for-each (lambda (u)
                           (let ((in (first u))
                                 (internal (second u))
                                 (out (if (null? (cddr u))
                                          (first u)
                                          (third u)))
                                 (uri (uri-reference (first u))))
                             (test (sprintf "~s decoded as ~s" in internal)
                                   internal ((cadr p) uri))
                             (test (sprintf "~s encoded to ~s" internal out)
                                   out (uri->string uri
                                                    (lambda (u p)
                                                      (if p (conc u ":" p) u))))))
                         (cddr p))))
            internal-representation-cases))

(test-group "absolute/relative distinction"
  (for-each (lambda (s)
              (test-assert (sprintf "~s is a relative ref" s)
                           (relative-ref? (uri-reference s)))
              (test-assert (sprintf "~s is not an URI" s)
                           (not (uri? (uri-reference s))))
              (test-assert (sprintf "~s is not an absolute URI" s)
                           (not (absolute-uri? (uri-reference s))))
              (test-error (absolute-uri s)))
            relative-refs)
  (for-each (lambda (s)
              (test-assert (sprintf "~s is not a relative ref" s)
                           (not (relative-ref? (uri-reference s))))
              (test-assert (sprintf "~s is an URI" s)
                           (uri? (uri-reference s)))
              (test-assert (sprintf "~s is an absolute URI" s)
                           (absolute-uri? (uri-reference s)))
              (test (uri-reference s) (absolute-uri s)))
            absolute-uris)
  (for-each (lambda (s)
              (test-assert (sprintf "~s is not a relative ref" s)
                           (not (relative-ref? (uri-reference s))))
              (test-assert (sprintf "~s is an URI" s)
                           (uri? (uri-reference s)))
              (test-assert (sprintf "~s is not an absolute URI" s)
                           (not (absolute-uri? (uri-reference s))))
              ;; Should this give an error in the fragment case?
              (test-error (absolute-uri s)))
            non-relative-non-absolute-uri-references))


(test-group "absolute/relative path distinction"
  (for-each (lambda (s)
              (test-assert (sprintf "~s is not a relative path" s)
                           (not (uri-path-relative? (uri-reference s))))
              (test-assert (sprintf "~s is an absolute path" s)
                           (uri-path-absolute? (uri-reference s))))
            absolute-paths)
  (for-each (lambda (s)
              (test-assert (sprintf "~s is a relative path" s)
                           (uri-path-relative? (uri-reference s)))
              (test-assert (sprintf "~s is not an absolute path" s)
                           (not (uri-path-absolute? (uri-reference s)))))
            relative-paths))


(test-group "Invalid URI-references"
  (for-each (lambda (s)
              (test (sprintf "~s is not a valid uri-reference" s)
                    #f
                    (uri-reference s)))
            invalid-refs))

(test-group "miscellaneous"
  ;; Special case, see section 4.2
  (test "./foo:bar" (uri->string (update-uri (uri-reference "") 'path '("foo:bar")))))


(test-group "Example URIs from RFC 4151"
  (for-each (lambda (s) 
              (test (car s) (cadr s) (uri->string (uri-reference (car s)))))
            rfc4151-refs))


(test-group "Example URIs from RFC 4452"
  (for-each (lambda (s) 
              (test (car s) (cadr s) (uri->string (uri-reference (car s)))))
            rfc4452-refs))


(test-group "Example URIs from RFC 4452"
  (for-each (lambda (s) 
              (test (car s) (cadr s) (uri->string (uri-reference (car s)))))
            rfc5724-refs))


(test-group "Example URIs from RFC 4501"
  (for-each (lambda (s) 
              (test (car s) (cadr s) (uri->string (uri-reference (car s)))))
            rfc4501-refs))


(test-group "Example URIs from RFC 5122"
  (for-each (lambda (s) 
              (test (car s) (cadr s) (map uri-decode-string (uri-path (uri-reference (car s))))))
            rfc5122-refs))


(test-group "manual constructor"
  (for-each (lambda (u)
              (let* ((input (cdr u))
                     (oexp (first u))
                     (oact (apply make-uri input)))
                (test (sprintf "~s -> ~s" input oexp)
                      oexp (uri->string oact))))
            make-cases))

(test-end "uri-generic")

;; (unless (zero? (test-failure-count)) (exit 1))

#t
)