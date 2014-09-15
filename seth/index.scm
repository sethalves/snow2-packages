(repository
  (url "http://snow2.s3-website-us-east-1.amazonaws.com/index.scm")
  (name "Seth Repository")
  (sibling
    (name "Snow Repository")
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/index.scm")
    (trust 1.0))
  (sibling
    (name "Chibi Repository")
    (url "http://snow-fort.org/pkg/repo")
    (trust 1.0))
  (package
    (name ())
    (version "1.0")
    (url "uuid.tgz")
    (size 6656)
    (checksum (md5 "66c64f4530000defc1ea2033cefa8f29"))
    (library
      (name (seth uuid))
      (path "seth/uuid.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "parse and generate uuids")
      (license bsd)
      (depends (srfi 60) (seth binary-pack) (srfi 13) (srfi 27))
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "binary-pack.tgz")
    (size 6144)
    (checksum (md5 "a3f71d9cdc72638519dbe37395d117c5"))
    (library
      (name (seth binary-pack))
      (path "seth/binary-pack.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "binary-pack")
      (license bsd)
      (depends (srfi 60) (snow bytevector))
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "port-extras.tgz")
    (size 8192)
    (checksum (md5 "90f26b605d40fea5105cca4dd51032d5"))
    (library
      (name (seth port-extras))
      (path "seth/port-extras.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "port-extras")
      (license bsd)
      (depends (snow bytevector))
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "aws.tgz")
    (size 21504)
    (checksum (md5 "20cca1be7302ca711e6b3b16ad90b58c"))
    (library
      (name (seth aws s3))
      (path "seth/aws/s3.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
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
        (srfi gauche-95)
        (srfi 14))
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "tar.tgz")
    (size 4608)
    (checksum (md5 "d98ed1635a774c83b61cd6f88e2ebcad"))
    (library
      (name (seth tar))
      (path "seth/tar.sld")
      (version "1.3")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "shell out to tar.")
      (license bsd)
      (depends)
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "xml.tgz")
    (size 431616)
    (checksum (md5 "3428cb37cf8a625c39ae2ba1cb85a0ae"))
    (library
      (name (seth xml ssax))
      (path "seth/xml/ssax.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
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
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Dmitry Lizorkin" "Jim Ursetto")
      (description "Serialize SXML to XML")
      (license bsd)
      (depends (srfi 1) (srfi 13))
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "message-digest.tgz")
    (size 57856)
    (checksum (md5 "059f3b43932609da63bd6b14725dd63d"))
    (library
      (name (seth message-digest parameters))
      (path "seth/message-digest/parameters.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
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
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends (seth message-digest type) (seth message-digest update-item))
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "string-read-write.tgz")
    (size 5632)
    (checksum (md5 "fb3fc11de0c7a9058d489f24e4cf195b"))
    (library
      (name (seth string-read-write))
      (path "seth/string-read-write.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "string-read-write")
      (license bsd)
      (depends)
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "temporary-file.tgz")
    (size 7168)
    (checksum (md5 "cdcc79c1122d6ad6272c6839ef8521e4"))
    (library
      (name (seth temporary-file))
      (path "seth/temporary-file.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "temporary-file")
      (license bsd)
      (depends (srfi 27))
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "variable-item.tgz")
    (size 6656)
    (checksum (md5 "7a3e06135ea32ef58ff841999b41fe6d"))
    (library
      (name (seth variable-item))
      (path "seth/variable-item.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "variable-item")
      (license BSD-style)
      (depends)
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "cout.tgz")
    (size 5120)
    (checksum (md5 "32e6cf572239d8dfebc915c7b98b065c"))
    (library
      (name (seth cout))
      (path "seth/cout.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "cout")
      (license bsd)
      (depends (srfi 1))
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "crypt.tgz")
    (size 54272)
    (checksum (md5 "f090e820d2eb443b01e3fa12630b0ccb"))
    (library
      (name (seth crypt md5))
      (path "seth/crypt/md5.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
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
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "hmac-sha-1")
      (license BSD-style)
      (depends
        (srfi 60)
        (seth port-extras)
        (seth crypt sha-1)
        (snow bytevector))
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "snow2-utils.tgz")
    (size 128000)
    (checksum (md5 "1420517d9b12caf85346b6ca093bb283"))
    (library
      (name (seth snow2 client))
      (path "seth/snow2/client.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "snow2-utils")
      (license bsd)
      (depends
        (srfi 1)
        (srfi 13)
        (snow filesys)
        (snow binio)
        (snow genport)
        (snow zlib)
        (snow tar)
        (srfi 27)
        (srfi 29)
        (seth http)
        (seth temporary-file)
        (seth string-read-write)
        (srfi 37)
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
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "snow2-utils")
      (license bsd)
      (depends (srfi 1) (srfi 13) (seth uri))
      (use-for final))
    (library
      (name (seth snow2 utils))
      (path "seth/snow2/utils.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "snow2-utils")
      (license bsd)
      (depends
        (srfi 1)
        (snow extio)
        (srfi 13)
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
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "memcache-client.tgz")
    (size 17920)
    (checksum (md5 "69f8d37d2cb6d130a5bf1a89c0f1d4c7"))
    (library
      (name (seth memcache-client))
      (path "seth/memcache-client.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
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
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "network-socket.tgz")
    (size 32256)
    (checksum (md5 "353097feebfeae7858bf0930e453f5e7"))
    (library
      (name (seth network-socket))
      (path "seth/network-socket.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "network-socket")
      (license bsd)
      (depends (seth gauche-socket-utils) (snow bytevector))
      (use-for final))
    (library
      (name (seth gauche-socket-utils))
      (path "seth/gauche-socket-utils.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "network-socket")
      (license bsd)
      (depends)
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "quoted-printable.tgz")
    (size 10752)
    (checksum (md5 "f6a6f9cd735dac39e0d997761a710f16"))
    (library
      (name (seth quoted-printable))
      (path "seth/quoted-printable.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Alex Shinn")
      (description
        "RFC 2045 quoted printable encoding and decoding utilities.  This API is backwards compatible with the Gauche library rfc.quoted-printable.")
      (license BSD-style "http://synthcode.com/license.txt")
      (depends (srfi 60) (srfi 13) (seth string-read-write))
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "zlib.tgz")
    (size 7680)
    (checksum (md5 "ec5dd45765861bfb7ece09ba0f23be02"))
    (library
      (name (seth zlib))
      (path "seth/zlib.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
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
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "gensym.tgz")
    (size 4096)
    (checksum (md5 "3b655b9e27886f6b81e3f4fadbb42e90"))
    (library
      (name (seth gensym))
      (path "seth/gensym.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "gensym")
      (license BSD-style)
      (depends)
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "uri.tgz")
    (size 47104)
    (checksum (md5 "3a7959f74a80986f14af8f1a2a876f23"))
    (library
      (name (seth uri))
      (path "seth/uri.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
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
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "base64.tgz")
    (size 14848)
    (checksum (md5 "7cb5a39919e674aaf221e7b9947243e6"))
    (library
      (name (seth base64))
      (path "seth/base64.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "base64")
      (license lgpl/v2.1)
      (depends (snow bytevector) (srfi 1) (srfi 60))
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "http.tgz")
    (size 20480)
    (checksum (md5 "fbe001c23adfaa044b0bff905d3c12de"))
    (library
      (name (seth http))
      (path "seth/http.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "http")
      (license bsd)
      (depends
        (snow gauche-extio-utils)
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
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "deep-copy.tgz")
    (size 4096)
    (checksum (md5 "99d09cc972ec15d0bbeadb737339b0dc"))
    (library
      (name (seth deep-copy))
      (path "seth/deep-copy.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "every scheme student, ever")
      (description
        "Copy a potentially nested structure containing any of the base types.")
      (license bsd)
      (depends)
      (use-for final)))
  (package
    (name ())
    (version "1.0")
    (url "mime.tgz")
    (size 19968)
    (checksum (md5 "f11d2028c5a2557308ff172f85cd9614"))
    (library
      (name (seth mime))
      (path "seth/mime.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
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
      (use-for final))))
