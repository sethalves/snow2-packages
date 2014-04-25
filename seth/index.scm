(repository
  (sibling
    (name "Seth Repository")
    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/")
    (trust 1.0))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/aws.tgz")
    (library
      (name (seth aws s3))
      (path "seth/aws/s3.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Thomas Hintz <t@thintz.com>")
      (description "")
      (license BSD-style)
      (depends
        (snow snowlib)
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
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Thomas Hintz <t@thintz.com>")
      (description "")
      (license BSD-style)
      (depends
        (snow bytevector)
        (snow srfi-13-strings)
        (snow srfi-95-sort)
        (snow srfi-29-format)
        (snow srfi-19-time)
        (snow extio)
        (seth xml ssax)
        (seth xml sxpath)
        (seth http)
        (seth crypt hmac-sha-1)
        (seth port-extras)
        (seth uri)
        (seth base64))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/base64.tgz")
    (library
      (name (seth base64))
      (path "seth/base64.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license lgpl/v2.1)
      (depends (snow bytevector))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/binary-pack.tgz")
    (library
      (name (seth binary-pack))
      (path "seth/binary-pack.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license lgpl/v2.1)
      (depends (snow bytevector))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/cout.tgz")
    (library
      (name (seth cout))
      (path "seth/cout.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/crypt.tgz")
    (library
      (name (seth crypt md5))
      (path "seth/crypt/md5.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Alex Shinn")
      (description "")
      (license BSD-style)
      (depends (snow bytevector) (snow srfi-60-integers-as-bits)))
    (library
      (name (seth crypt sha-1))
      (path "seth/crypt/sha-1.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license BSD-style)
      (depends (snow bytevector) (snow srfi-60-integers-as-bits)))
    (library
      (name (seth crypt sha-2))
      (path "seth/crypt/sha-2.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Alex Shinn")
      (description "")
      (license BSD-style)
      (depends (snow bytevector) (snow srfi-60-integers-as-bits)))
    (library
      (name (seth crypt hmac-sha-1))
      (path "seth/crypt/hmac-sha-1.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license BSD-style)
      (depends
        (snow bytevector)
        (snow srfi-60-integers-as-bits)
        (snow srfi-13-strings)
        (seth port-extras)
        (seth crypt sha-1))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/gensym.tgz")
    (library
      (name (seth gensym))
      (path "seth/gensym.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license BSD-style)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/http.tgz")
    (library
      (name (seth http))
      (path "seth/http.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license lgpl/v2.1)
      (depends
        (snow snowlib)
        (snow bytevector)
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
    (library
      (name (seth memcache-client))
      (path "seth/memcache-client.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license lgpl/v2.1)
      (depends
        (snow bytevector)
        (snow srfi-13-strings)
        (snow binio)
        (seth network-socket)
        (seth string-read-write)
        (seth port-extras)
        (seth base64))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/message-digest.tgz")
    (library
      (name (seth message-digest parameters))
      (path "seth/message-digest/parameters.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "")
      (license BSD)
      (depends (seth variable-item)))
    (library
      (name (seth message-digest primitive))
      (path "seth/message-digest/primitive.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "")
      (license BSD)
      (depends (seth gensym)))
    (library
      (name (seth message-digest type))
      (path "seth/message-digest/type.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "")
      (license BSD)
      (depends
        (snow snowlib)
        (snow bytevector)
        (seth message-digest primitive)))
    (library
      (name (seth message-digest support))
      (path "seth/message-digest/support.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "")
      (license BSD)
      (depends (seth message-digest primitive) (seth message-digest type)))
    (library
      (name (seth message-digest bv))
      (path "seth/message-digest/bv.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "")
      (license BSD)
      (depends
        (seth message-digest primitive)
        (seth message-digest type)
        (seth message-digest support)))
    (library
      (name (seth message-digest port))
      (path "seth/message-digest/port.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "")
      (license BSD)
      (depends
        (seth string-read-write)
        (seth srfi-69-hash-tables)
        (seth message-digest primitive)
        (seth message-digest type)
        (seth message-digest bv)))
    (library
      (name (seth message-digest update-item))
      (path "seth/message-digest/update-item.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "")
      (license BSD)
      (depends
        (snow snowlib)
        (snow bytevector)
        (seth message-digest parameters)
        (seth message-digest primitive)
        (seth message-digest type)
        (seth message-digest support)))
    (library
      (name (seth message-digest md5))
      (path "seth/message-digest/md5.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "")
      (license BSD)
      (depends
        (snow bytevector)
        (snow srfi-60-integers-as-bits)
        (seth message-digest primitive)))
    (library
      (name (seth message-digest item))
      (path "seth/message-digest/item.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "")
      (license BSD)
      (depends (seth message-digest type) (seth message-digest update-item))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/mime.tgz")
    (library
      (name (seth mime))
      (path "seth/mime.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Alex Shinn")
      (description "")
      (license BSD-style "http://synthcode.com/license.txt")
      (depends
        (snow srfi-13-strings)
        (snow extio)
        (seth quoted-printable)
        (seth base64)
        (snow binio))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/network-socket.tgz")
    (library
      (name (seth network-socket))
      (path "seth/network-socket.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license bsd)
      (depends (seth port-extras) (snow bytevector)))
    (library
      (name (seth gauche-socket-utils))
      (path "seth/gauche-socket-utils.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license bsd)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/port-extras.tgz")
    (library
      (name (seth port-extras))
      (path "seth/port-extras.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license lgpl/v2.1)
      (depends (snow bytevector) (snow binio) (seth string-read-write))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/quoted-printable.tgz")
    (library
      (name (seth quoted-printable))
      (path "seth/quoted-printable.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Alex Shinn")
      (description "")
      (license BSD-style "http://synthcode.com/license.txt")
      (depends (snow srfi-60-integers-as-bits) (snow srfi-13-strings))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/snow2-utils.tgz")
    (library
      (name (seth snow2 client))
      (path "seth/snow2/client.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license mit)
      (depends
        (snow snowlib)
        (snow extio)
        (snow srfi-13-strings)
        (seth srfi-69-hash-tables)
        (snow filesys)
        (snow binio)
        (snow genport)
        (snow zlib)
        (snow tar)
        (seth http)
        (seth temporary-file)
        (seth srfi-37-argument-processor)))
    (library
      (name (seth snow2 manage))
      (path "seth/snow2/manage.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license mit)
      (depends
        (snow snowlib)
        (snow extio)
        (snow srfi-13-strings)
        (seth srfi-69-hash-tables)
        (snow filesys)
        (snow binio)
        (seth crypt md5)
        (snow genport)
        (snow zlib)
        (snow tar)
        (seth aws common)
        (seth aws s3)
        (seth http)
        (seth temporary-file)
        (seth srfi-37-argument-processor)))
    (library
      (name (seth snow2 types))
      (path "seth/snow2/types.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license mit)
      (depends
        (snow snowlib)
        (snow extio)
        (snow srfi-13-strings)
        (seth srfi-69-hash-tables)
        (snow filesys)
        (snow binio)
        (snow genport)
        (snow zlib)
        (snow tar)
        (seth http)
        (seth temporary-file)
        (seth srfi-37-argument-processor)))
    (library
      (name (seth snow2 utils))
      (path "seth/snow2/utils.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license mit)
      (depends
        (snow snowlib)
        (snow extio)
        (snow srfi-13-strings)
        (seth srfi-69-hash-tables)
        (snow filesys)
        (snow binio)
        (snow genport)
        (snow zlib)
        (snow tar)
        (seth http)
        (seth temporary-file)
        (seth srfi-37-argument-processor))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/srfi-27-random.tgz")
    (library
      (name (seth srfi-27-random))
      (path "seth/srfi-27-random.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/srfi-37-argument-processor.tgz")
    (library
      (name (seth srfi-37-argument-processor))
      (path "seth/srfi-37-argument-processor.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Anthony Carrico")
      (description "")
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/srfi-69-hash-tables.tgz")
    (library
      (name (seth srfi-69-hash-tables))
      (path "seth/srfi-69-hash-tables.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/string-read-write.tgz")
    (library
      (name (seth string-read-write))
      (path "seth/string-read-write.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/tar.tgz")
    (library
      (name (seth tar))
      (path "seth/tar.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license lgpl/v2.1)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/temporary-file.tgz")
    (library
      (name (seth temporary-file))
      (path "seth/temporary-file.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license lgpl/v2.1)
      (depends (seth srfi-27-random))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/uri.tgz")
    (library
      (name (seth uri))
      (path "seth/uri.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Ivan Raikov" "Peter Bex")
      (description "")
      (license bsd)
      (depends
        (snow snowlib)
        (snow srfi-13-strings)
        (seth string-read-write))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/uuid.tgz")
    (library
      (name (seth uuid))
      (path "seth/uuid.sld")
      (version "1.0")
      (homepage "https://github.com/sethalves")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "parse and generate uuids")
      (license lgpl/v2.1)
      (depends
        (snow bytevector)
        (snow srfi-60-integers-as-bits)
        (seth binary-pack)
        (snow srfi-13-strings)
        (seth srfi-27-random))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/variable-item.tgz")
    (library
      (name (seth variable-item))
      (path "seth/variable-item.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Kon Lovett")
      (description "")
      (license BSD-style)
      (depends)))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/xml.tgz")
    (library
      (name (seth xml ssax))
      (path "seth/xml/ssax.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Oleg Kiselyov")
      (description "")
      (license public-domain)
      (depends
        (snow snowlib)
        (snow extio)
        (snow assert)
        (snow srfi-13-strings)))
    (library
      (name (seth xml sxpath))
      (path "seth/xml/sxpath.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors)
      (description "")
      (license public-domain)
      (depends
        (snow extio)
        (snow assert)
        (snow srfi-13-strings)
        (snow input-parse))))
  (package
    (name ())
    (url "http://snow2.s3-website-us-east-1.amazonaws.com/zlib.tgz")
    (library
      (name (seth zlib))
      (path "seth/zlib.sld")
      (version "1.0")
      (homepage "")
      (maintainers "Seth Alves <seth@hungry.com>")
      (authors "Seth Alves <seth@hungry.com>")
      (description "")
      (license BSD-style)
      (depends (snow genport) (snow zlib)))))
