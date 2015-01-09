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
  (package
    (name ())
    (version "1.0")
    (url "uuid.tgz")
    (size 8704)
    (checksum (md5 "bef8a8739a226d2c8203810694234736"))
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
    (checksum (md5 "53519a8a34deddcbfb803f89219f4bcb"))
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
    (checksum (md5 "bdf076c7292ed3da029f4bc71090e5fc"))
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
    (checksum (md5 "4019016acf17ef2b09a25ef05297b7b0"))
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
    (checksum (md5 "058cff0f4644fb64f48ba27f2c2aa02b"))
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
    (checksum (md5 "b2cce0439f1720a1c0423411bef52bd5"))
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
    (checksum (md5 "61a777e2b5e9899e8e143a041af2671e"))
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
    (checksum (md5 "f12076bb249b56acd8fc4b7dc2a00d26"))
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
    (checksum (md5 "c57810e32c3094ac367ede7f1a5db176"))
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
    (checksum (md5 "e6f2c649ec4164b2a58462b126086fae"))
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
    (checksum (md5 "ef96885dd450f6b734b709580128c3bf"))
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
    (size 145408)
    (checksum (md5 "08fc3f8730fa461097146d7d6f18313b"))
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
    (checksum (md5 "2e21bdaad1651dea93fef31f2c234c6d"))
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
    (size 43520)
    (checksum (md5 "b09df2343a614b838712244fdac30385"))
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
      (name ("."))
      (path "seth/gauche-socket-utils.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (manual)
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "network-socket")
      (license bsd)
      (depends)
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
    (checksum (md5 "eb3881e82a49adb14727575fa77748aa"))
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
    (checksum (md5 "e15b4316beedfd439586534a7d59df72"))
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
    (checksum (md5 "d3f4936a656c32e9ad1cf65faf2ec5aa"))
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
    (checksum (md5 "e3f05e52fb6aea2ab335d16dfe81fd7c"))
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
    (checksum (md5 "18da1729137ca03e3660658dc9e9afaf"))
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
    (checksum (md5 "8e080712a74f2567df47358c317ddfab"))
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
    (checksum (md5 "6c9f49c4532aa244b6de4983dbd87576"))
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
    (checksum (md5 "3e368ab59bad74ce308683f089f5c62d"))
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
