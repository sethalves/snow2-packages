(repository
  (sibling
    (name "Snow Repository")
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/")
    (trust 1.0))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/aws.tgz")
    (size 19991)
    (checksum (md5 "c8f989813df575cb88ba262e80e55e07"))
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
        (snow srfi-13-strings)
        (snow extio)
        (seth uri)
        (seth port-extras)
        (seth xml ssax)
        (seth xml sxpath)
        (seth http)
        (seth aws common)))
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
        (snow bytevector)
        (snow srfi-13-strings)
        (snow srfi-95-sort)
        (snow srfi-29-format)
        (snow srfi-19-time)
        (snow extio)
        (seth http)
        (seth crypt hmac-sha-1)
        (seth uri)
        (seth base64))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/base64.tgz")
    (size 13847)
    (checksum (md5 "5dd48db0f4942cb2ca1ba297df206a54"))
    (library
      (name (seth base64))
      (path "seth/base64.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "base64")
      (license lgpl/v2.1)
      (depends (snow bytevector))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/binary-pack.tgz")
    (size 5143)
    (checksum (md5 "828cc94f9e28fd92f2b2d6cb17b2c0a0"))
    (library
      (name (seth binary-pack))
      (path "seth/binary-pack.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "binary-pack")
      (license bsd)
      (depends (snow bytevector))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/cout.tgz")
    (size 4119)
    (checksum (md5 "4b5c711d51be631b1a4d4ec489d97eda"))
    (library
      (name (seth cout))
      (path "seth/cout.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "cout")
      (license bsd)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/crypt.tgz")
    (size 52247)
    (checksum (md5 "d8c20bc90aa332d04ca061b2e93b3fd1"))
    (library
      (name (seth crypt md5))
      (path "seth/crypt/md5.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Alex Shinn")
      (description "md5")
      (license BSD-style)
      (depends (snow bytevector) (snow srfi-60-integers-as-bits)))
    (library
      (name (seth crypt sha-1))
      (path "seth/crypt/sha-1.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "sha-1")
      (license BSD-style)
      (depends (snow srfi-60-integers-as-bits) (snow bytevector)))
    (library
      (name (seth crypt sha-2))
      (path "seth/crypt/sha-2.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Alex Shinn")
      (description "sha-2")
      (license BSD-style)
      (depends (snow srfi-60-integers-as-bits) (snow bytevector)))
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
        (snow srfi-60-integers-as-bits)
        (seth port-extras)
        (seth crypt sha-1)
        (snow bytevector))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/gensym.tgz")
    (size 3095)
    (checksum (md5 "5df4613075ae5de6eace0dc4fd157879"))
    (library
      (name (seth gensym))
      (path "seth/gensym.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "gensym")
      (license BSD-style)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/http.tgz")
    (size 19479)
    (checksum (md5 "ca7b19afa69972256beae551e5b4e1b3"))
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
        (snow bytevector)
        (snow binio)
        (snow srfi-29-format)
        (snow srfi-13-strings)
        (snow extio)
        (seth mime)
        (seth string-read-write)
        (seth uri)
        (seth port-extras)
        (seth network-socket))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/memcache-client.tgz")
    (size 16919)
    (checksum (md5 "872c3bd98f93d44bae709676cb021546"))
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
        (snow srfi-13-strings)
        (snow binio)
        (seth network-socket)
        (seth string-read-write)
        (seth base64))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/message-digest.tgz")
    (size 54807)
    (checksum (md5 "0816f02584a281914e566e0972b2140c"))
    (library
      (name (seth message-digest parameters))
      (path "seth/message-digest/parameters.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends (seth variable-item)))
    (library
      (name (seth message-digest primitive))
      (path "seth/message-digest/primitive.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends (seth gensym)))
    (library
      (name (seth message-digest type))
      (path "seth/message-digest/type.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends (snow bytevector) (seth message-digest primitive)))
    (library
      (name (seth message-digest support))
      (path "seth/message-digest/support.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends (seth message-digest primitive) (seth message-digest type)))
    (library
      (name (seth message-digest bv))
      (path "seth/message-digest/bv.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends (seth message-digest type) (seth message-digest support)))
    (library
      (name (seth message-digest port))
      (path "seth/message-digest/port.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends
        (seth srfi-69-hash-tables)
        (seth message-digest type)
        (seth message-digest bv)))
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
        (seth message-digest type)))
    (library
      (name (seth message-digest md5))
      (path "seth/message-digest/md5.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends
        (snow srfi-60-integers-as-bits)
        (seth message-digest primitive)))
    (library
      (name (seth message-digest item))
      (path "seth/message-digest/item.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "message-digest")
      (license BSD)
      (depends (seth message-digest type) (seth message-digest update-item))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/mime.tgz")
    (size 18967)
    (checksum (md5 "013d397363491cb0a6d15571aa30cd6e"))
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
        (seth base64)
        (seth quoted-printable)
        (snow srfi-13-strings)
        (snow binio))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/network-socket.tgz")
    (size 27671)
    (checksum (md5 "6f923d6e746119e2376165dca83f99d6"))
    (library
      (name (seth network-socket))
      (path "seth/network-socket.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "network-socket")
      (license bsd)
      (depends (seth gauche-socket-utils) (snow bytevector)))
    (library
      (name (seth gauche-socket-utils))
      (path "seth/gauche-socket-utils.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "network-socket")
      (license bsd)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/port-extras.tgz")
    (size 7703)
    (checksum (md5 "4db7d3990a0129a2024c076e54da3c97"))
    (library
      (name (seth port-extras))
      (path "seth/port-extras.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "port-extras")
      (license bsd)
      (depends (snow bytevector))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/quoted-printable.tgz")
    (size 9751)
    (checksum (md5 "0c2a3b5047c06090b5ca64977c387803"))
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
      (depends (snow srfi-60-integers-as-bits) (snow srfi-13-strings))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/snow2-utils.tgz")
    (size 103964)
    (checksum (md5 "52c7616453d3949e61d57c454edd53b1"))
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
        (snow srfi-13-strings)
        (snow filesys)
        (snow binio)
        (snow genport)
        (snow zlib)
        (snow tar)
        (snow srfi-29-format)
        (seth http)
        (seth temporary-file)
        (seth string-read-write)
        (seth srfi-37-argument-processor)
        (seth uri)
        (seth crypt md5)
        (seth snow2 types)
        (seth snow2 utils)
        (seth snow2 r7rs-library)
        (seth snow2 manage)))
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
        (snow bytevector)
        (snow tar)
        (snow zlib)
        (snow filesys)
        (snow srfi-13-strings)
        (snow extio)
        (snow srfi-29-format)
        (seth uri)
        (seth crypt md5)
        (seth aws common)
        (seth aws s3)
        (seth snow2 types)
        (seth snow2 utils)
        (seth snow2 r7rs-library)))
    (library
      (name (seth snow2 types))
      (path "seth/snow2/types.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "snow2-utils")
      (license bsd)
      (depends (seth uri)))
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
        (snow extio)
        (snow srfi-13-strings)
        (seth srfi-69-hash-tables)
        (snow srfi-29-format)
        (snow filesys)
        (seth http)
        (seth uri)
        (seth snow2 types)))
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
        (snow srfi-29-format)
        (snow srfi-95-sort)
        (seth snow2 types)
        (seth snow2 utils))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/srfi-27-random.tgz")
    (size 3095)
    (checksum (md5 "6536a56dd3fda8c5e4e150397eaa5b1e"))
    (library
      (name (seth srfi-27-random))
      (path "seth/srfi-27-random.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "srfi-27-random")
      (license bsd)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/srfi-37-argument-processor.tgz")
    (size 13335)
    (checksum (md5 "57cb177d2eb7de294287a58f3dabb6e5"))
    (library
      (name (seth srfi-37-argument-processor))
      (path "seth/srfi-37-argument-processor.sld")
      (version "1.0")
      (homepage "http://srfi.schemers.org/srfi-37/srfi-37.html")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Anthony Carrico")
      (description "srfi-27-random")
      (license bsd)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/srfi-69-hash-tables.tgz")
    (size 18455)
    (checksum (md5 "6dc54ab30d165fbbf6055213698ddbbb"))
    (library
      (name (seth srfi-69-hash-tables))
      (path "seth/srfi-69-hash-tables.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "srfi-69-hash-tables")
      (license bsd)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/string-read-write.tgz")
    (size 4119)
    (checksum (md5 "da9f538edeaedd745b84b4a0f048b71c"))
    (library
      (name (seth string-read-write))
      (path "seth/string-read-write.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "string-read-write")
      (license bsd)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/tar.tgz")
    (size 3607)
    (checksum (md5 "8a7ab983416282d3f0515fb4a5ad1c9e"))
    (library
      (name (seth tar))
      (path "seth/tar.sld")
      (version "1.3")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "shell out to tar")
      (license bsd)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/temporary-file.tgz")
    (size 5143)
    (checksum (md5 "24ba85e23bc68d1f79f6942ec7e1149f"))
    (library
      (name (seth temporary-file))
      (path "seth/temporary-file.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "temporary-file")
      (license bsd)
      (depends (seth srfi-27-random))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/uri.tgz")
    (size 45591)
    (checksum (md5 "686c49804a2f43b959815b9b036020eb"))
    (library
      (name (seth uri))
      (path "seth/uri.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Ivan Raikov" "Peter Bex")
      (description "uri")
      (license bsd)
      (depends (snow srfi-13-strings) (seth string-read-write))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/uuid.tgz")
    (size 5655)
    (checksum (md5 "ebf7fbc174b5c0dcd31ce29bed1fd09b"))
    (library
      (name (seth uuid))
      (path "seth/uuid.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "parse and generate uuids")
      (license bsd)
      (depends
        (snow srfi-60-integers-as-bits)
        (seth binary-pack)
        (snow srfi-13-strings)
        (seth srfi-27-random))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/variable-item.tgz")
    (size 5655)
    (checksum (md5 "6f5518842f108e2c8a23776c4cf1a223"))
    (library
      (name (seth variable-item))
      (path "seth/variable-item.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "variable-item")
      (license BSD-style)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/xml.tgz")
    (size 332336)
    (checksum (md5 "b2085ae61237d962ff9dcb772947bcc6"))
    (library
      (name (seth xml ssax))
      (path "seth/xml/ssax.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Oleg Kiselyov")
      (description "XML parser")
      (license public-domain)
      (depends (snow assert) (snow srfi-13-strings) (snow input-parse)))
    (library
      (name (seth xml sxpath))
      (path "seth/xml/sxpath.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors)
      (description "XML parser")
      (license public-domain)
      (depends (snow assert) (snow srfi-13-strings) (snow extio))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/zlib.tgz")
    (size 6679)
    (checksum (md5 "9dab820d9fed9377da9d01b761a362e9"))
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
        (snow bytevector)
        (snow genport)
        (seth port-extras)))))
