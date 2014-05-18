(repository
  (sibling
    (name "Snow Repository")
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/")
    (trust 1.0))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/srfi-14-character-sets.tgz")
    (size 34327)
    (checksum (md5 "723e99fb88b2e8489f21f3de93edf370"))
    (library
      (name (snow srfi-14-character-sets))
      (path "snow/srfi-14-character-sets.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "srfi-14-character-sets")
      (license BSD-style)
      (depends (snow srfi-60-integers-as-bits))))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/srfi-1-lists.tgz")
    (size 27159)
    (checksum (md5 "de4f2c568aa429351c25b7f058da9961"))
    (library
      (name ())
      (path "snow/srfi-1-lists.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors)
      (description "srfi-1-lists")
      (license olin-shivers-doesnt-care)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/assert.tgz")
    (size 2583)
    (checksum (md5 "62bbe7549be040470dbdfb1487755f3b"))
    (library
      (name ())
      (path "snow/assert.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "assert")
      (license bsd)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/bignum.tgz")
    (size 39447)
    (checksum (md5 "bd6ff300d073b56f749501995135619f"))
    (library
      (name ())
      (path "snow/bignum.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Operations on large integers." math snow)
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/binio.tgz")
    (size 8215)
    (checksum (md5 "ce0dff1e414dcd77ebe7bd5fefb6abfe"))
    (library
      (name ())
      (path "snow/binio.sld")
      (version "1.0.2")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Binary I/O." i/o snow)
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/bytevector.tgz")
    (size 13847)
    (checksum (md5 "1da55c7eb85700a3799efe2061364752"))
    (library
      (name ())
      (path "snow/bytevector.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "bytevector compatibility layer")
      (license bsd)
      (depends))
    (library
      (name (snow gauche-bv-string-utils))
      (path "snow/gauche-bv-string-utils.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "bytevector compatibility layer")
      (license bsd)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/digest.tgz")
    (size 64023)
    (checksum (md5 "1331d5f9af6ef1290d48b2545806568c"))
    (library
      (name ())
      (path "snow/digest.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description
        "Computation of message digests (CRC32, MD5, SHA-1, ...)."
        hash
        conv
        snow)
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/extio.tgz")
    (size 40983)
    (checksum (md5 "e764d63dd32d4ce94f2dd1d477e59f29"))
    (library
      (name ())
      (path "snow/extio.sld")
      (version "1.0.3")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Seth Alves <alves@hungry.com>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Extended I/O." i/o snow)
      (license lgpl/v2.1)
      (depends))
    (library
      (name (snow gauche-extio-utils))
      (path "snow/gauche-extio-utils.sld")
      (version "1.0.3")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Seth Alves <alves@hungry.com>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Extended I/O." i/o snow)
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/filesys.tgz")
    (size 34327)
    (checksum (md5 "ac23bd00807172068502d2e1553e3c38"))
    (library
      (name ())
      (path "snow/filesys.sld")
      (version "1.0.4")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "File system access." os snow)
      (license lgpl/v2.1)
      (depends))
    (library
      (name (snow gauche-filesys-utils))
      (path "snow/gauche-filesys-utils.sld")
      (version "1.0.4")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "File system access." os snow)
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/genport.tgz")
    (size 13847)
    (checksum (md5 "3e26c40d95d29dff9c3c7d7b13756053"))
    (library
      (name ())
      (path "snow/genport.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Generic ports." i/o snow)
      (license lgpl/v2.1)
      (depends))
    (library
      (name (snow gauche-genport-utils))
      (path "snow/gauche-genport-utils.sld")
      (version "1.0")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "Generic ports." i/o snow)
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/hello.tgz")
    (size 3095)
    (checksum (md5 "cb114fd245f5827700b56177979321b6"))
    (library
      (name ())
      (path "snow/hello.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Display \"let it snow\" and pi." example snow)
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/input-parse.tgz")
    (size 12311)
    (checksum (md5 "1ec7a0a08777801428857f3effebfb85"))
    (library
      (name ())
      (path "snow/input-parse.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description
        "inspired and compatible with Oleg Kiselyov's input parsing library")
      (license public-domain)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/pi.tgz")
    (size 4631)
    (checksum (md5 "a680409683432c9a7ce17f11765e03e2"))
    (library
      (name ())
      (path "snow/pi.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Computes the digits of pi." example snow)
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/processio.tgz")
    (size 8727)
    (checksum (md5 "2ec6dca8be19fb8aae93ccfea840ba45"))
    (library
      (name ())
      (path "snow/processio.sld")
      (version "1.0.0")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Seth Alves <alves@hungry.com")
      (authors
        "Nils M Holm <nmh at t3x.org>"
        "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "I/O to operating system subprocesses." i/o os)
      (license bsdl)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/random.tgz")
    (size 5143)
    (checksum (md5 "dd67d812985ceb143eea65456e5e7d79"))
    (library
      (name ())
      (path "snow/random.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "High-quality random number generation." snow)
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/snowlib.tgz")
    (size 14359)
    (checksum (md5 "0a79a665f245f57b8b85d2c0858de405"))
    (library
      (name ())
      (path "snow/snowlib.sld")
      (version "1.2.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Scheme Now! runtime library." snow)
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/srfi-13-strings.tgz")
    (size 16407)
    (checksum (md5 "fdd86ad289393c0b202b49dd55e22706"))
    (library
      (name ())
      (path "snow/srfi-13-strings.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors)
      (description "srfi-13-strings")
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/srfi-19-time.tgz")
    (size 58903)
    (checksum (md5 "89866b679861d5111f3b555aab274231"))
    (library
      (name ())
      (path "snow/srfi-19-time.sld")
      (version "1.0")
      (homepage "http://srfi.schemers.org/srfi-19/srfi-19.html")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Will Fitzgerald" "Neodesic Corporation")
      (description "srfi-19-time")
      (license BSD-style)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/srfi-29-format.tgz")
    (size 10775)
    (checksum (md5 "7cbabb369f0617e496408873e4ed740d"))
    (library
      (name ())
      (path "snow/srfi-29-format.sld")
      (version "1.0")
      (homepage "http://srfi.schemers.org/srfi-29/srfi-29.html")
      (maintainers)
      (authors)
      (description "srfi-29-format")
      (license mit)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/srfi-60-integers-as-bits.tgz")
    (size 9751)
    (checksum (md5 "247910fbf60354d80c28819464e52a06"))
    (library
      (name ())
      (path "snow/srfi-60-integers-as-bits.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "bytevector compatibility layer")
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/srfi-95-sort.tgz")
    (size 12823)
    (checksum (md5 "b29690976157963373741e993bc39a1f"))
    (library
      (name ())
      (path "snow/srfi-95-sort.sld")
      (version "1.0")
      (homepage
        "http://srfi.schemers.org/srfi-95/srfi-95.html"
        "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Aubrey Jaffer" "Richard A. O'Keefe" "D.H.D. Warren")
      (description "Sorting and Merging")
      (license public-domain)
      (depends))
    (library
      (name (snow gauche-sort-utils))
      (path "snow/gauche-sort-utils.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "Sorting and Merging")
      (license public-domain)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/tar.tgz")
    (size 25111)
    (checksum (md5 "65c8382f472f5cf48c57ccf32a1800c1"))
    (library
      (name ())
      (path "snow/tar.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "TAR file format packing and unpacking." conv snow)
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/zlib.tgz")
    (size 45591)
    (checksum (md5 "a250a504fd2c304316b86b9e4b3196e6"))
    (library
      (name ())
      (path "snow/zlib.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors
        "Marc Feeley <feeley at iro.umontreal.ca>"
        "Manuel Serrano <Manuel.Serrano at sophia.inria.fr>")
      (description
        "Compression and decompression of deflate and gzip formats."
        conv
        i/o
        snow)
      (license lgpl/v2.1)
      (depends))))
