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
    (checksum (md5 "c373e3498feafdc86804b6c925864a58"))
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
    (checksum (md5 "bd49eff69d0d4e60360831dae50fc9ee"))
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
    (checksum (md5 "3e5f94d72bd21e1eb4ff19a68407f510"))
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
    (checksum (md5 "a402392c205be05c4f0b17f753990890"))
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
    (checksum (md5 "277ce22d74d8db8fc64d8bc356dc01bb"))
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
    (checksum (md5 "d6cafe690d83be6163cb925fab46507f"))
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
    (checksum (md5 "cee8f2e616e7993f59bf497bd1960d6e"))
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
    (checksum (md5 "07179fef0fc8bb5f418e22f91670dad6"))
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
    (checksum (md5 "fecf35bb621fea5ac3da379580f039dd"))
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
    (checksum (md5 "0ddeebae4767afb48107973f80d1c798"))
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
    (checksum (md5 "bd61c7ae7dd96e951fa32166cc2bc636"))
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
    (checksum (md5 "a0f0b8cf5148d08e21381348f406f2b7"))
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
    (checksum (md5 "5773941d26e5616396d7072a728073cf"))
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
    (checksum (md5 "2e02830c145e15c2ca703f8335d09107"))
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
    (checksum (md5 "e4f5d094b1cfc6be8f30cb43afe8f548"))
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
