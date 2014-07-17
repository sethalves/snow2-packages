(repository
  (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/index.scm")
  (name "Snow Repository")
  (sibling
    (name "r7rs srfis")
    (url "http://r7rs-srfis.s3-website-us-east-1.amazonaws.com/index.scm")
    (trust 1.0))
  (package
    (name ())
    (version "1.0")
    (url "tar.tgz")
    (size 25600)
    (checksum (md5 "9180a72103a4acb6c554ee445fb86163"))
    (library
      (name (snow tar))
      (path "snow/tar.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "TAR file format packing and unpacking." conv snow)
      (license lgpl/v2.1)
      (depends
        (snow bytevector)
        (srfi 60)
        (snow bignum)
        (snow genport)
        (snow filesys))))
  (package
    (name ())
    (version "1.0")
    (url "bignum.tgz")
    (size 40448)
    (checksum (md5 "26543a444a2daf75c7bf63baa8bac506"))
    (library
      (name (snow bignum))
      (path "snow/bignum.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Operations on large integers." math snow)
      (license lgpl/v2.1)
      (depends (snow bytevector))))
  (package
    (name ())
    (version "1.0")
    (url "processio.tgz")
    (size 9728)
    (checksum (md5 "41a5381e287b8006de5d01c45993ae04"))
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
      (depends (snow filesys) (snow extio))))
  (package
    (name ())
    (version "1.0")
    (url "genport.tgz")
    (size 15360)
    (checksum (md5 "f22cbb4706f95f11e9bc2f265440771e"))
    (library
      (name (snow genport))
      (path "snow/genport.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Generic ports." i/o snow)
      (license lgpl/v2.1)
      (depends (snow bytevector) (snow binio) (snow gauche-genport-utils)))
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
    (version "1.0")
    (url "filesys.tgz")
    (size 17920)
    (checksum (md5 "8537a78a844c8e4c9720b22a2238675d"))
    (library
      (name (snow filesys))
      (path "snow/filesys.sld")
      (version "1.0.4")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "File system access." os snow)
      (license lgpl/v2.1)
      (depends (srfi 13) (snow gauche-filesys-utils) (srfi 1) (srfi 14)))
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
    (version "1.0")
    (url "pi.tgz")
    (size 5632)
    (checksum (md5 "97c5f4beb29b1a72ee2facd372e5fef5"))
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
    (name ())
    (version "1.0")
    (url "hello.tgz")
    (size 4096)
    (checksum (md5 "12cfcced48be0590bbadc71aa0ae5bcf"))
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
    (name ())
    (version "1.0")
    (url "extio.tgz")
    (size 42496)
    (checksum (md5 "b28f23e4ed94b5571faae429e8470712"))
    (library
      (name (snow extio))
      (path "snow/extio.sld")
      (version "1.0.3")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Seth Alves <alves@hungry.com>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Extended I/O." i/o snow)
      (license lgpl/v2.1)
      (depends
        (snow gauche-extio-utils)
        (snow bytevector)
        (srfi 60)
        (srfi 13)))
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
    (version "1.0")
    (url "zlib.tgz")
    (size 46080)
    (checksum (md5 "dd99fb322e299e8519649041d219ad8e"))
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
      (depends (snow bytevector) (snow digest) (srfi 60) (snow genport))))
  (package
    (name ())
    (version "1.0")
    (url "random.tgz")
    (size 6144)
    (checksum (md5 "554c94936fcb6f8941fbfa2390fa24e6"))
    (library
      (name (snow random))
      (path "snow/random.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "High-quality random number generation." snow)
      (license lgpl/v2.1)
      (depends (srfi 27) (snow bytevector) (snow binio) (snow bignum))))
  (package
    (name ())
    (version "1.0")
    (url "bytevector.tgz")
    (size 15360)
    (checksum (md5 "8bb36b7aeee76438e2cad8c4a951299f"))
    (library
      (name (snow bytevector))
      (path "snow/bytevector.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "bytevector compatibility layer")
      (license bsd)
      (depends (srfi 1) (snow gauche-bv-string-utils)))
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
    (version "1.0")
    (url "input-parse.tgz")
    (size 13312)
    (checksum (md5 "49a07de9a05852f5ab3ccc9bba4dc94c"))
    (library
      (name (snow input-parse))
      (path "snow/input-parse.sld")
      (version "1.0.1")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description
        "inspired and compatible with Oleg Kiselyov's input parsing library")
      (license public-domain)
      (depends (srfi 1) (srfi 13))))
  (package
    (name ())
    (version "1.0")
    (url "binio.tgz")
    (size 9216)
    (checksum (md5 "04d2b85ce3cc3e0d8687e8878cb2114e"))
    (library
      (name (snow binio))
      (path "snow/binio.sld")
      (version "1.0.2")
      (homepage "http://snow.iro.umontreal.ca")
      (maintainers "Scheme Now! <snow at iro.umontreal.ca>")
      (authors "Marc Feeley <feeley at iro.umontreal.ca>")
      (description "Binary I/O." i/o snow)
      (license lgpl/v2.1)
      (depends (snow bytevector))))
  (package
    (name ())
    (version "1.0")
    (url "assert.tgz")
    (size 3584)
    (checksum (md5 "724e840f092071658a4e171b8ee15f88"))
    (library
      (name (snow assert))
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
    (version "1.0")
    (url "digest.tgz")
    (size 65024)
    (checksum (md5 "a05b377693fb6434c45a460e0abcbe25"))
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
      (depends (srfi 60) (snow binio) (snow bytevector)))))
