(repository
  (url "http://snow2.s3-website-us-east-1.amazonaws.com/index.scm")
  (name "Snow2 Repository")
  (sibling
    (name "Snow Repository")
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/index.scm")
    (trust 1.0))
  (sibling
    (name "Chibi Repository")
    (url "http://snow-fort.s3-website-us-east-1.amazonaws.com/repo.scm")
    (trust 1.0))
  (sibling
    (name "Industria")
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/industria/index.scm")
    (trust 1.0))
  (package
    (name ())
    (version "1.0")
    (url "math-3d.tgz")
    (size 57856)
    (checksum (md5 "7a1492305e01d8eadf79c89568ea99db"))
    (library
      (name (seth math-3d))
      (path "seth/math-3d.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "utilities for doing 3d math")
      (license bsd)
      (depends (seth cout))
      (use-for final))
    (library
      (name (seth math-3d tests))
      (path "seth/math-3d/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for math-3d")
      (license bsd)
      (depends (seth math-3d) (seth cout))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "obj-model.tgz")
    (size 18944)
    (checksum (md5 "4a117955ca6f4418effce71e5696c43b"))
    (library
      (name (seth obj-model))
      (path "seth/obj-model.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <alves@hungry.com>")
      (authors "Seth Alves <alves@hungry.com>")
      (description "parse and generate obj-models")
      (license bsd)
      (depends (srfi 13) (srfi 29) (srfi 69) (snow assert) (snow input-parse))
      (use-for final))
    (library
      (name (seth obj-model tests))
      (path "seth/obj-model/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <alves@hungry.com>")
      (authors "Seth Alves <alves@hungry.com>")
      (description "tests for obj-model")
      (license bsd)
      (depends (seth obj-model))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "debian-version.tgz")
    (size 27648)
    (checksum (md5 "52f14a73e42a210f31e946ba0990c37c"))
    (library
      (name (seth debian-version))
      (path "seth/debian-version.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "debian-version")
      (license bsd)
      (depends (srfi 1) (srfi 13) (srfi 14) (snow assert))
      (use-for final))
    (library
      (name (seth debian-version tests))
      (path "seth/debian-version/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for debian-version")
      (license bsd)
      (depends (snow bytevector) (srfi 78) (seth debian-version))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "alexpander.tgz")
    (size 93696)
    (checksum (md5 "5403ca96959d62d87ae177cca6489e93"))
    (library
      (name (seth alexpander))
      (path "seth/alexpander.sld")
      (version "1.0")
      (homepage "http://petrofsky.org/src/alexpander.scm")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Al Petrofsky <alexpander@petrofsky.org>")
      (description "a macro-expander for r5rs scheme")
      (license "3-clause BSD or GNU GPL 2 and up")
      (depends (snow extio))
      (use-for final))
    (library
      (name (seth alexpander tests))
      (path "seth/alexpander/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for alexpander")
      (license bsd)
      (depends (seth alexpander))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "uuid.tgz")
    (size 8704)
    (checksum (md5 "b0332c642ede34184cea79eb4470805e"))
    (library
      (name (seth uuid))
      (path "seth/uuid.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "parse and generate uuids")
      (license bsd)
      (depends (srfi 60) (seth binary-pack) (srfi 13) (srfi 27))
      (use-for final))
    (library
      (name (seth uuid tests))
      (path "seth/uuid/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for uuid")
      (license bsd)
      (depends (srfi 27) (seth uuid))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "binary-pack.tgz")
    (size 8192)
    (checksum (md5 "52592d0c69ba5d9ba091f0ee2da3c492"))
    (library
      (name (seth binary-pack))
      (path "seth/binary-pack.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "binary-pack")
      (license bsd)
      (depends (srfi 60) (snow bytevector))
      (use-for final))
    (library
      (name (seth binary-pack tests))
      (path "seth/binary-pack/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for binary-pack")
      (license bsd)
      (depends (snow bytevector) (seth binary-pack))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "port-extras.tgz")
    (size 10752)
    (checksum (md5 "4ea7d72a597ecf27ff41e2721ee6473d"))
    (library
      (name (seth port-extras))
      (path "seth/port-extras.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "port-extras")
      (license bsd)
      (depends (snow bytevector))
      (use-for final))
    (library
      (name (seth port-extras tests))
      (path "seth/port-extras/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for port-extras")
      (license bsd)
      (depends (seth port-extras))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "aws.tgz")
    (size 27136)
    (checksum (md5 "db91271c2be1b3c8689f086a1fd3278e"))
    (library
      (name (seth aws s3))
      (path "seth/aws/s3.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Thomas Hintz <t@thintz.com>")
      (description "aws")
      (license BSD-style)
      (depends
        (snow bytevector)
        (srfi 13)
        (snow extio)
        (seth uri)
        (seth port-extras)
        (seth xml ssax)
        (seth xml sxpath)
        (seth http)
        (seth aws common))
      (use-for final))
    (library
      (name (seth aws common))
      (path "seth/aws/common.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Thomas Hintz <t@thintz.com>")
      (description "aws")
      (license BSD-style)
      (depends
        (srfi 1)
        (snow bytevector)
        (srfi 13)
        (srfi 95)
        (srfi 29)
        (srfi 19)
        (snow extio)
        (seth http)
        (seth crypt hmac-sha-1)
        (seth uri)
        (seth base64)
        (srfi 14))
      (use-for final))
    (library
      (name (seth aws tests))
      (path "seth/aws/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for aws")
      (license bsd)
      (depends
        (srfi 13)
        (snow bytevector)
        (seth base64)
        (seth http)
        (seth crypt md5)
        (seth aws common)
        (seth aws s3)
        (srfi 78))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "xml.tgz")
    (size 437248)
    (checksum (md5 "4db3b01bddd5611c30dbed21a96752e2"))
    (library
      (name (seth xml ssax))
      (path "seth/xml/ssax.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Oleg Kiselyov")
      (description "XML parser")
      (license public-domain)
      (depends
        (srfi 1)
        (srfi 13)
        (snow input-parse)
        (snow assert)
        (seth string-read-write))
      (use-for final))
    (library
      (name (seth xml sxpath))
      (path "seth/xml/sxpath.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors)
      (description "XML parser")
      (license public-domain)
      (depends
        (srfi 13)
        (seth string-read-write)
        (srfi 1)
        (srfi 2)
        (snow assert)
        (snow extio))
      (use-for final))
    (library
      (name (seth xml sxml-serializer))
      (path "seth/xml/sxml-serializer.sld")
      (version "1.0")
      (homepage "http://wiki.call-cc.org/eggref/4/sxml-serializer")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Dmitry Lizorkin" "Jim Ursetto")
      (description "Serialize SXML to XML")
      (license bsd)
      (depends (srfi 1) (srfi 13))
      (use-for final))
    (library
      (name (seth xml tests))
      (path "seth/xml/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for xml")
      (license bsd)
      (depends
        (srfi 1)
        (srfi 13)
        (snow extio)
        (snow assert)
        (seth xml ssax)
        (seth xml sxpath)
        (seth xml sxml-serializer))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "message-digest.tgz")
    (size 70656)
    (checksum (md5 "464e9cb46d91a971c8c0dae269bbf977"))
    (library
      (name (seth message-digest parameters))
      (path "seth/message-digest/parameters.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends (seth variable-item))
      (use-for final))
    (library
      (name (seth message-digest primitive))
      (path "seth/message-digest/primitive.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends (seth gensym))
      (use-for final))
    (library
      (name (seth message-digest type))
      (path "seth/message-digest/type.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends (snow bytevector) (seth message-digest primitive))
      (use-for final))
    (library
      (name (seth message-digest support))
      (path "seth/message-digest/support.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends (seth message-digest primitive) (seth message-digest type))
      (use-for final))
    (library
      (name (seth message-digest bv))
      (path "seth/message-digest/bv.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends (seth message-digest type) (seth message-digest support))
      (use-for final))
    (library
      (name (seth message-digest port))
      (path "seth/message-digest/port.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends (srfi 69) (seth message-digest type) (seth message-digest bv))
      (use-for final))
    (library
      (name (seth message-digest update-item))
      (path "seth/message-digest/update-item.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends
        (seth message-digest parameters)
        (seth message-digest primitive)
        (seth message-digest type))
      (use-for final))
    (library
      (name (seth message-digest md5))
      (path "seth/message-digest/md5.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends (srfi 60) (seth message-digest primitive))
      (use-for final))
    (library
      (name (seth message-digest item))
      (path "seth/message-digest/item.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends (seth message-digest type) (seth message-digest update-item))
      (use-for final))
    (library
      (name (seth message-digest tests))
      (path "seth/message-digest/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for message-digest")
      (license bsd)
      (depends
        (snow bytevector)
        (seth message-digest primitive)
        (seth message-digest type)
        (seth message-digest bv)
        (seth message-digest port)
        (seth message-digest md5)
        (seth message-digest update-item)
        (seth message-digest item))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "string-read-write.tgz")
    (size 7680)
    (checksum (md5 "049011369c94b5aa03a8d45b5fb9fcba"))
    (library
      (name (seth string-read-write))
      (path "seth/string-read-write.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "string-read-write")
      (license bsd)
      (depends)
      (use-for final))
    (library
      (name (seth string-read-write tests))
      (path "seth/string-read-write/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for string-read-write")
      (license bsd)
      (depends (seth string-read-write))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "temporary-file.tgz")
    (size 9728)
    (checksum (md5 "5636c80594fa4e3682a23230da19d109"))
    (library
      (name (seth temporary-file))
      (path "seth/temporary-file.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "temporary-file")
      (license bsd)
      (depends (srfi 27))
      (use-for final))
    (library
      (name (seth temporary-file tests))
      (path "seth/temporary-file/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for temporary-file")
      (license bsd)
      (depends (seth temporary-file))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "variable-item.tgz")
    (size 8704)
    (checksum (md5 "cc645d130aaaa0a7036b765680ff8ee7"))
    (library
      (name (seth variable-item))
      (path "seth/variable-item.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "variable-item")
      (license BSD-style)
      (depends)
      (use-for final))
    (library
      (name (seth variable-item tests))
      (path "seth/variable-item/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for variable-item")
      (license bsd)
      (depends (seth variable-item))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "cout.tgz")
    (size 7168)
    (checksum (md5 "fa167c3dc08d4355fc946270f1d3742c"))
    (library
      (name (seth cout))
      (path "seth/cout.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "cout")
      (license bsd)
      (depends (srfi 1))
      (use-for final))
    (library
      (name (seth cout tests))
      (path "seth/cout/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for cout")
      (license bsd)
      (depends (seth cout))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "crypt.tgz")
    (size 139776)
    (checksum (md5 "3a4484f9e6075efcff050c9fb59be723"))
    (library
      (name (seth crypt md5))
      (path "seth/crypt/md5.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Alex Shinn")
      (description "md5")
      (license BSD-style)
      (depends (snow bytevector) (srfi 60))
      (use-for final))
    (library
      (name (seth crypt sha-1))
      (path "seth/crypt/sha-1.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "sha-1")
      (license BSD-style)
      (depends (srfi 60) (snow bytevector))
      (use-for final))
    (library
      (name (seth crypt sha-2))
      (path "seth/crypt/sha-2.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Alex Shinn")
      (description "sha-2")
      (license BSD-style)
      (depends (srfi 60) (snow bytevector))
      (use-for final))
    (library
      (name (seth crypt hmac-sha-1))
      (path "seth/crypt/hmac-sha-1.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "hmac-sha-1")
      (license BSD-style)
      (depends
        (srfi 60)
        (seth port-extras)
        (seth crypt sha-1)
        (snow bytevector))
      (use-for final))
    (library
      (name (seth crypt tests))
      (path "seth/crypt/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for crypt")
      (license bsd)
      (depends
        (snow bytevector)
        (seth crypt sha-1)
        (seth crypt sha-2)
        (seth crypt md5)
        (seth crypt hmac-sha-1))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "snow2-utils.tgz")
    (size 153088)
    (checksum (md5 "90920f465084d805c4cb843a33cdbc70"))
    (library
      (name (seth snow2 client))
      (path "seth/snow2/client.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "snow2-utils")
      (license bsd)
      (depends
        (srfi 1)
        (srfi 13)
        (srfi 37)
        (srfi 27)
        (srfi 29)
        (snow filesys)
        (snow binio)
        (snow genport)
        (snow zlib)
        (snow tar)
        (snow assert)
        (seth http)
        (seth cout)
        (seth temporary-file)
        (seth string-read-write)
        (seth uri)
        (seth crypt md5)
        (seth snow2 types)
        (seth snow2 utils)
        (seth snow2 r7rs-library)
        (seth snow2 manage))
      (use-for final))
    (library
      (name (seth snow2 manage))
      (path "seth/snow2/manage.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "snow2 types")
      (license bsd)
      (depends
        (seth cout)
        (srfi 1)
        (snow bytevector)
        (snow tar)
        (snow zlib)
        (snow filesys)
        (srfi 13)
        (snow extio)
        (snow assert)
        (srfi 29)
        (seth uri)
        (seth crypt md5)
        (seth aws common)
        (seth aws s3)
        (seth snow2 types)
        (seth snow2 utils)
        (seth snow2 r7rs-library)
        (srfi 95)
        (seth string-read-write))
      (use-for final))
    (library
      (name (seth snow2 types))
      (path "seth/snow2/types.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "snow2-utils")
      (license bsd)
      (depends (srfi 1) (srfi 13) (seth uri) (seth string-read-write))
      (use-for final))
    (library
      (name (seth snow2 utils))
      (path "seth/snow2/utils.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "snow2-utils")
      (license bsd)
      (depends
        (srfi 95)
        (snow assert)
        (seth cout)
        (srfi 1)
        (snow extio)
        (srfi 13)
        (srfi 14)
        (srfi 69)
        (srfi 29)
        (snow filesys)
        (seth http)
        (seth string-read-write)
        (seth uri)
        (seth snow2 types)
        (seth xml sxml-serializer)
        (seth deep-copy))
      (use-for final))
    (library
      (name (seth snow2 r7rs-library))
      (path "seth/snow2/r7rs-library.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "snow2-utils")
      (license bsd)
      (depends
        (snow filesys)
        (srfi 29)
        (srfi 95)
        (seth snow2 types)
        (seth snow2 utils)
        (srfi 1))
      (use-for final))
    (library
      (name (seth snow2 tests))
      (path "seth/snow2/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for snow2-utils")
      (license bsd)
      (depends (seth snow2 client))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "memcache-client.tgz")
    (size 20992)
    (checksum (md5 "a7b4d44f1260bc321cf2f1dc1eb31df6"))
    (library
      (name (seth memcache-client))
      (path "seth/memcache-client.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "memcache-client")
      (license bsd)
      (depends
        (snow bytevector)
        (srfi 13)
        (snow binio)
        (seth network-socket)
        (seth string-read-write)
        (seth base64))
      (use-for final))
    (library
      (name (seth memcache-client tests))
      (path "seth/memcache-client/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for memcache-client")
      (license bsd)
      (depends (seth cout) (seth memcache-client))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "network-socket.tgz")
    (size 42496)
    (checksum (md5 "cb66f3788bcf12ee00af84c600ff57b4"))
    (library
      (name (seth network-socket))
      (path "seth/network-socket.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "network-socket")
      (license bsd)
      (depends (snow bytevector))
      (use-for final))
    (library
      (name (seth network-socket tests))
      (path "seth/network-socket/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for network-socket")
      (license bsd)
      (depends (srfi 27) (seth port-extras) (seth network-socket))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "quoted-printable.tgz")
    (size 13824)
    (checksum (md5 "01c0f107dbce9e1e1c7a8725c95728d9"))
    (library
      (name (seth quoted-printable))
      (path "seth/quoted-printable.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Alex Shinn")
      (description
        "RFC 2045 quoted printable encoding and decoding utilities.  This API is backwards compatible with the Gauche library rfc.quoted-printable.")
      (license BSD-style "http://synthcode.com/license.txt")
      (depends (srfi 60) (srfi 13) (seth string-read-write))
      (use-for final))
    (library
      (name (seth quoted-printable tests))
      (path "seth/quoted-printable/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for quoted-printable")
      (license bsd)
      (depends (seth quoted-printable))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "zlib.tgz")
    (size 10752)
    (checksum (md5 "0b36d3eb27999ba513487f0c08bad187"))
    (library
      (name (seth zlib))
      (path "seth/zlib.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "zlib")
      (license BSD-style)
      (depends
        (snow zlib)
        (srfi 1)
        (snow bytevector)
        (snow genport)
        (seth port-extras))
      (use-for final))
    (library
      (name (seth zlib tests))
      (path "seth/zlib/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for zlib")
      (license bsd)
      (depends (seth port-extras) (snow genport) (seth zlib))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "gensym.tgz")
    (size 6144)
    (checksum (md5 "f1d6855c78b50415ca14557c1f52a04a"))
    (library
      (name (seth gensym))
      (path "seth/gensym.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "gensym")
      (license BSD-style)
      (depends)
      (use-for final))
    (library
      (name (seth gensym tests))
      (path "seth/gensym/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for gensym")
      (license bsd)
      (depends (seth gensym))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "uri.tgz")
    (size 77312)
    (checksum (md5 "70d8384392811643223180b1bf0a4011"))
    (library
      (name (seth uri))
      (path "seth/uri.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Ivan Raikov" "Peter Bex")
      (description "uri")
      (license bsd)
      (depends
        (chibi optional)
        (chibi match)
        (srfi 1)
        (srfi 14)
        (srfi 13)
        (seth string-read-write))
      (use-for final))
    (library
      (name (seth uri tests))
      (path "seth/uri/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for uri")
      (license bsd)
      (depends (srfi 1) (srfi 29) (seth string-read-write) (seth uri))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "base64.tgz")
    (size 32256)
    (checksum (md5 "ea7e5665590e6c56f118592a5b6f5b1c"))
    (library
      (name (seth base64))
      (path "seth/base64.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "base64")
      (license lgpl/v2.1)
      (depends (snow bytevector) (srfi 1) (srfi 60))
      (use-for final))
    (library
      (name (seth base64 tests))
      (path "seth/base64/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for base64")
      (license bsd)
      (depends (snow bytevector) (seth base64))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "http.tgz")
    (size 29184)
    (checksum (md5 "a73079f37daa6ae42ca00fe89c6273f7"))
    (library
      (name (seth http))
      (path "seth/http.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "http")
      (license bsd)
      (depends
        (srfi 1)
        (srfi 14)
        (snow bytevector)
        (snow binio)
        (srfi 29)
        (srfi 13)
        (snow extio)
        (seth mime)
        (seth string-read-write)
        (seth uri)
        (seth port-extras)
        (seth network-socket))
      (use-for final))
    (library
      (name (seth http tests))
      (path "seth/http/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for http")
      (license bsd)
      (depends (snow binio) (snow extio) (seth port-extras) (seth http))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "deep-copy.tgz")
    (size 6144)
    (checksum (md5 "fb1ae088708d3501fb3c2d0d2b66a14a"))
    (library
      (name (seth deep-copy))
      (path "seth/deep-copy.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "every scheme student, ever")
      (description
        "Copy a potentially nested structure containing any of the base types.")
      (license bsd)
      (depends)
      (use-for final))
    (library
      (name (seth deep-copy tests))
      (path "seth/deep-copy/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for deep-copy")
      (license bsd)
      (depends (seth deep-copy))
      (use-for test)))
  (package
    (name ())
    (version "1.0")
    (url "mime.tgz")
    (size 23040)
    (checksum (md5 "b31443da56fd3d37a973ab381b7372f0"))
    (library
      (name (seth mime))
      (path "seth/mime.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Alex Shinn")
      (description "RFC2045 MIME library")
      (license BSD-style "http://synthcode.com/license.txt")
      (depends
        (seth quoted-printable)
        (seth string-read-write)
        (seth base64)
        (srfi 13)
        (snow binio))
      (use-for final))
    (library
      (name (seth mime tests))
      (path "seth/mime/tests.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "tests for mime")
      (license bsd)
      (depends (seth mime))
      (use-for test))))
