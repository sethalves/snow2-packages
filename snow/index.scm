(repository
  (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/index.scm")
  (name "Snow Repository")
  (sibling
    (name "r7rs srfis")
    (url "http://r7rs-srfis.s3-website-us-east-1.amazonaws.com/index.scm")
    (trust 1.0))
  (package
    (name (snow hello))
    (version "1.0")
    (url "hello.tgz")
    (size 6144)
    (checksum (md5 "09bd4752bb942a2ad9296b40019e9f0c"))
    (library
      (name (snow hello))
      (path "snow/hello.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (manual)
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Display \"let it snow\" and pi." example snow)
      (license lgpl/v2.1)
      (depends (snow pi))
      (use-for final))
    (library
      (name (snow hello tests))
      (path "snow/hello/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for hello")
      (license bsd)
      (depends (snow hello))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "tar.tgz")
    (size 27648)
    (checksum (md5 "a0e6affc3f532c4ba296cec373bf6b9f"))
    (library
      (name (snow tar))
      (path "snow/tar.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (manual)
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "TAR file format packing and unpacking." conv snow)
      (license lgpl/v2.1)
      (depends
        (snow bytevector)
        (srfi 60)
        (snow bignum)
        (snow genport)
        (snow filesys))
      (use-for final))
    (library
      (name (snow tar tests))
      (path "snow/tar/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for tar")
      (license bsd)
      (depends (snow tar))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "bignum.tgz")
    (size 44544)
    (checksum (md5 "406a4293bf1226cf6e04d2983220e656"))
    (library
      (name (snow bignum))
      (path "snow/bignum.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (manual)
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Operations on large integers." math snow)
      (license lgpl/v2.1)
      (depends (snow bytevector))
      (use-for final))
    (library
      (name (snow bignum tests))
      (path "snow/bignum/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for bignum")
      (license bsd)
      (depends (snow bignum))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "processio.tgz")
    (size 15872)
    (checksum (md5 "ceb519289d6e13d5bba5c52c35cc0c30"))
    (library
      (name (snow processio))
      (path "snow/processio.sld")
      (version "1.0.0")
      (homepage "http://snow.iro.umontreal.ca")
      (manual)
      (maintainers "Seth Alves <alves@hungry.com")
      (authors
        "Nils M Holm <nmh at t3x.org>"
        "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "I/O to operating system subprocesses." i/o os)
      (license bsdl)
      (depends (snow filesys) (snow extio))
      (use-for final))
    (library
      (name (snow processio tests))
      (path "snow/processio/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for processio")
      (license bsd)
      (depends
        (snow bytevector)
        (snow filesys)
        (snow extio)
        (snow assert)
        (snow binio)
        (snow processio))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "genport.tgz")
    (size 16384)
    (checksum (md5 "19831b32aedb072f9e44ef661b03b99e"))
    (library
      (name (snow genport))
      (path "snow/genport.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (manual)
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Generic ports." i/o snow)
      (license lgpl/v2.1)
      (depends (snow bytevector) (snow binio))
      (use-for final))
    (library
      (name (snow genport tests))
      (path "snow/genport/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for genport")
      (license bsd)
      (depends (snow genport))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "filesys.tgz")
    (size 23552)
    (checksum (md5 "3b5e7965ae0b83a8982640bba2a2efa1"))
    (library
      (name (snow filesys))
      (path "snow/filesys.sld")
      (version "1.0.4")
      (homepage "http://snow.iro.umontreal.ca")
      (manual)
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "File system access." os snow)
      (license lgpl/v2.1)
      (depends (srfi 13) (srfi 1) (srfi 14))
      (use-for final))
    (library
      (name (snow filesys tests))
      (path "snow/filesys/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for filesys")
      (license bsd)
      (depends (srfi 1) (snow filesys) (srfi 78))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "pi.tgz")
    (size 7680)
    (checksum (md5 "278d9053743e59e16e752ec4e71bbc39"))
    (library
      (name (snow pi))
      (path "snow/pi.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (manual)
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Computes the digits of pi." example snow)
      (license lgpl/v2.1)
      (depends (snow bignum))
      (use-for final))
    (library
      (name (snow pi tests))
      (path "snow/pi/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for pi")
      (license bsd)
      (depends (snow pi))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "extio.tgz")
    (size 50176)
    (checksum (md5 "df567f0bb5120b12697f378532c462df"))
    (library
      (name (snow extio))
      (path "snow/extio.sld")
      (version "1.0.3")
      (homepage "http://snow.iro.umontreal.ca")
      (manual)
      (maintainers "Seth Alves <alves@hungry.com>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Extended I/O." i/o snow)
      (license lgpl/v2.1)
      (depends (snow bytevector) (srfi 60) (srfi 13))
      (use-for final))
    (library
      (name (snow extio tests))
      (path "snow/extio/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for extio")
      (license bsd)
      (depends (snow bytevector) (snow extio))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "zlib.tgz")
    (size 48640)
    (checksum (md5 "5c640caca662e41d9cdd41b6dfc93559"))
    (library
      (name (snow zlib))
      (path "snow/zlib.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (manual)
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
      (depends (snow bytevector) (snow digest) (srfi 60) (snow genport))
      (use-for final))
    (library
      (name (snow zlib tests))
      (path "snow/zlib/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for zlib")
      (license bsd)
      (depends (snow binio) (snow genport) (snow zlib))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "random.tgz")
    (size 8192)
    (checksum (md5 "27a5a7590bdffc3c45569013e348de15"))
    (library
      (name (snow random))
      (path "snow/random.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (manual)
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "High-quality random number generation." snow)
      (license lgpl/v2.1)
      (depends (srfi 27) (snow bytevector) (snow binio) (snow bignum))
      (use-for final))
    (library
      (name (snow random tests))
      (path "snow/random/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for random")
      (license bsd)
      (depends (snow random))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "bytevector.tgz")
    (size 17408)
    (checksum (md5 "ef49a76943296980e53a51d642133e11"))
    (library
      (name (snow bytevector))
      (path "snow/bytevector.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "bytevector compatibility layer")
      (license bsd)
      (depends (srfi 1))
      (use-for final))
    (library
      (name (snow bytevector tests))
      (path "snow/bytevector/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "bytevector")
      (license bsd)
      (depends (snow bytevector))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "input-parse.tgz")
    (size 15360)
    (checksum (md5 "74128424167947c595b18ce1a45c212a"))
    (library
      (name (snow input-parse))
      (path "snow/input-parse.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (manual)
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description
        "inspired and compatible with Oleg Kiselyov's input parsing library")
      (license public-domain)
      (depends (srfi 1) (srfi 13))
      (use-for final))
    (library
      (name (snow input-parse tests))
      (path "snow/input-parse/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for input-parse")
      (license bsd)
      (depends (snow input-parse))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "binio.tgz")
    (size 11264)
    (checksum (md5 "837afd3756d04dd8e85f5b1cc68006f8"))
    (library
      (name (snow binio))
      (path "snow/binio.sld")
      (version "1.0.2")
      (homepage "http://snow.iro.umontreal.ca")
      (manual)
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Binary I/O." i/o snow)
      (license lgpl/v2.1)
      (depends (snow bytevector))
      (use-for final))
    (library
      (name (snow binio tests))
      (path "snow/binio/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for binio")
      (license bsd)
      (depends (snow binio))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "assert.tgz")
    (size 5632)
    (checksum (md5 "c2f0f9fd3ce46081e0ca226945624b96"))
    (library
      (name (snow assert))
      (path "snow/assert.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "assert")
      (license bsd)
      (depends)
      (use-for final))
    (library
      (name (snow assert tests))
      (path "snow/assert/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for assert")
      (license bsd)
      (depends (snow assert))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "digest.tgz")
    (size 59392)
    (checksum (md5 "79e88817de4b2a6970b17a99eb6eb2d0"))
    (library
      (name (snow digest))
      (path "snow/digest.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (manual)
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description
        "Computation of message digests (CRC32, MD5, SHA-1, ...)."
        hash
        conv
        snow)
      (license lgpl/v2.1)
      (depends (srfi 60) (snow binio) (snow bytevector))
      (use-for final))
    (library
      (name (snow digest tests))
      (path "snow/digest/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "tests for digest")
      (license lgpl/v2.1)
      (depends (snow bytevector) (snow digest))
      (use-for test))))
