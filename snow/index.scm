(repository
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/assert.tgz")
    (library
      (name (snow assert))
      (path "snow/assert.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "assert")
      (license lgpl/v2.1)))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/bignum.tgz")
    (library
      (name (snow bignum))
      (path "snow/bignum.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Operations on large integers." math snow)
      (depends (snow bytevector))
      (license lgpl/v2.1)))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/binio.tgz")
    (library
      (name (snow binio))
      (path "snow/binio.sld")
      (version "1.0.2")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Binary I/O." i/o snow)
      (depends (snow bytevector))
      (license lgpl/v2.1)))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/bytevector.tgz")
    (library
      (name (snow bytevector))
      (path "snow/bytevector.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "bytevector compatibility layer")
      (license lgpl/v2.1)))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/digest.tgz")
    (library
      (name (snow digest))
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
      (depends
        (snow srfi-60-integers-as-bits)
        (snow binio)
        (snow bytevector)
        (snow binio))))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/extio.tgz")
    (library
      (name (snow extio))
      (path "snow/extio.sld")
      (version "1.0.3")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Seth Alves <alves@hungry.com>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Extended I/O." i/o snow)
      (license lgpl/v2.1)))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/filesys.tgz")
    (library
      (name (snow filesys))
      (path "snow/filesys.sld")
      (version "1.0.4")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "File system access." os snow)
      (license lgpl/v2.1)
      (depends (snow random) (snow srfi-13-strings))))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/genport.tgz")
    (library
      (name (snow genport))
      (path "snow/genport.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Generic ports." i/o snow)
      (license lgpl/v2.1)
      (depends (snow binio)
               (snow filesys)
               (snow bytevector)
               )))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/hello.tgz")
    (library
      (name (snow hello))
      (path "snow/hello.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Display \"let it snow\" and pi." example snow)
      (license lgpl/v2.1)
      (depends (snow pi))))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/input-parse.tgz")
    (library
      (name (snow input-parse))
      (path "snow/input-parse.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "inspired and compatible with Oleg Kiselyov's input parsing library")
      (license public-domain)
      (depends
       (snow snowlib)
       (snow srfi-13-strings)
       )
      ))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/pi.tgz")
    (library
      (name (snow pi))
      (path "snow/pi.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Computes the digits of pi." example snow)
      (license lgpl/v2.1)
      (depends (snow bignum))))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/processio.tgz")
    (library
      (name (snow processio))
      (path "snow/processio.sld")
      (version "1.0.0")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Seth Alves <alves@hungry.com")
      (authors
        "Nils M Holm <nmh at t3x.org>"
        "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "I/O to operating system subprocesses." i/o os)
      (license bsdl)
      (depends (snow snowlib)
               (snow extio)
               (snow filesys))))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/random.tgz")
    (library
      (name (snow random))
      (path "snow/random.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "High-quality random number generation." snow)
      (license lgpl/v2.1)
      (depends (snow binio) (snow bignum))))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/snowlib.tgz")
    (library
      (name (snow snowlib))
      (path "snow/snowlib.sld")
      (version "1.2.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Scheme Now! runtime library." snow)
      (license lgpl/v2.1)))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/srfi-13-strings.tgz")
    (library
      (name (snow srfi-13-strings))
      (path "snow/srfi-13-strings.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors )
      (description "srfi-13-strings")
      (license lgpl/v2.1)))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/srfi-29-format.tgz")
    (library
      (name (snow srfi-29-format))
      (path "snow/srfi-29-format.sld")
      (version "1.0")
      (homepage "http://srfi.schemers.org/srfi-29/srfi-29.html")
      (maintainers)
      (authors )
      (description "srfi-29-format")
      (depends (snow snowlib))
      (license mit)))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/srfi-60-integers-as-bits.tgz")
    (library
      (name (snow srfi-60-integers-as-bits))
      (path "snow/srfi-60-integers-as-bits.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "bytevector compatibility layer")
      (license lgpl/v2.1)))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/tar.tgz")
    (library
      (name (snow tar))
      (path "snow/tar.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "TAR file format packing and unpacking." conv snow)
      (license lgpl/v2.1)
      (depends (snow snowlib) (snow bignum) (snow genport) (snow filesys))))
  (package
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/zlib.tgz")
    (library
      (name (snow zlib))
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
      (depends
        (snow snowlib)
        (snow bytevector)
        (snow digest)
        (snow srfi-60-integers-as-bits)
        (snow genport)
        (snow digest))))
)
