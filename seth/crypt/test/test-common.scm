
(define (test-md5)
  (let ((tests
         (list
          (list "" "d41d8cd98f00b204e9800998ecf8427e")
          (list "a" "0cc175b9c0f1b6a831c399e269772661")
          (list "abc" "900150983cd24fb0d6963f7d28e17f72")
          (list "message digest" "f96b697d7cb7938d525a2f31aaf161d0")
          (list "abcdefghijklmnopqrstuvwxyz"
                "c3fcd3d76192e4007dfb496cca67e13b")
          (list (string-append "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklm"
                               "nopqrstuvwxyz0123456789")
                "d174ab98d277d9f5a5611c2c9f419d9f")
          (list (string-append "1234567890123456789012345678901234567890"
                               "1234567890123456789012345678901234567890")
                "57edf4a22be3c955ac49da2e2107b67a")

          (list "abc" "900150983cd24fb0d6963f7d28e17f72")
          (list "The quick brown fox jumps over the lazy dog"
                "9e107d9d372bb6826bd81d3542a419d6")

          (list "" "d41d8cd98f00b204e9800998ecf8427e")
          (list "a" "0cc175b9c0f1b6a831c399e269772661")
          (list "abc" "900150983cd24fb0d6963f7d28e17f72")
          (list "message digest" "f96b697d7cb7938d525a2f31aaf161d0")
          (list "abcdefghijklmnopqrstuvwxyz" "c3fcd3d76192e4007dfb496cca67e13b")
          (list "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
                "d174ab98d277d9f5a5611c2c9f419d9f")
          (list "12345678901234567890123456789012345678901234567890123456789012345678901234567890"
                "57edf4a22be3c955ac49da2e2107b67a")
          (list "1631901HERR BUCHHEISTERCITROEN NORD1043360796beckenbauer"
                "d734945e5930bb28859ccd13c830358b")
          ;; Test padding for strings from 0 to 69*8 bits in size.
          (list "" "d41d8cd98f00b204e9800998ecf8427e")
          (list "a" "0cc175b9c0f1b6a831c399e269772661")
          (list "aa" "4124bc0a9335c27f086f24ba207a4912")
          (list "aaa" "47bce5c74f589f4867dbd57e9ca9f808")
          (list "aaaa" "74b87337454200d4d33f80c4663dc5e5")
          (list "aaaaa" "594f803b380a41396ed63dca39503542")
          (list "aaaaaa" "0b4e7a0e5fe84ad35fb5f95b9ceeac79")
          (list "aaaaaaa" "5d793fc5b00a2348c3fb9ab59e5ca98a")
          (list "aaaaaaaa" "3dbe00a167653a1aaee01d93e77e730e")
          (list "aaaaaaaaa" "552e6a97297c53e592208cf97fbb3b60")
          (list "aaaaaaaaaa" "e09c80c42fda55f9d992e59ca6b3307d")
          (list "aaaaaaaaaaa" "d57f21e6a273781dbf8b7657940f3b03")
          (list "aaaaaaaaaaaa" "45e4812014d83dde5666ebdf5a8ed1ed")
          (list "aaaaaaaaaaaaa" "c162de19c4c3731ca3428769d0cd593d")
          (list "aaaaaaaaaaaaaa" "451599a5f9afa91a0f2097040a796f3d")
          (list "aaaaaaaaaaaaaaa" "12f9cf6998d52dbe773b06f848bb3608")
          (list "aaaaaaaaaaaaaaaa" "23ca472302f49b3ea5592b146a312da0")
          (list "aaaaaaaaaaaaaaaaa" "88e42e96cc71151b6e1938a1699b0a27")
          (list "aaaaaaaaaaaaaaaaaa" "2c60c24e7087e18e45055a33f9a5be91")
          (list "aaaaaaaaaaaaaaaaaaa" "639d76897485360b3147e66e0a8a3d6c")
          (list "aaaaaaaaaaaaaaaaaaaa" "22d42eb002cefa81e9ad604ea57bc01d")
          (list "aaaaaaaaaaaaaaaaaaaaa" "bd049f221af82804c5a2826809337c9b")
          (list "aaaaaaaaaaaaaaaaaaaaaa" "ff49cfac3968dbce26ebe7d4823e58bd")
          (list "aaaaaaaaaaaaaaaaaaaaaaa" "d95dbfee231e34cccb8c04444412ed7d")
          (list "aaaaaaaaaaaaaaaaaaaaaaaa" "40edae4bad0e5bf6d6c2dc5615a86afb")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaa"
                "a5a8bfa3962f49330227955e24a2e67c")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaa"
                "ae791f19bdf77357ff10bb6b0e97e121")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "aaab9c59a88bf0bdfcb170546c5459d6")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "b0f0545856af1a340acdedce23c54b97")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "f7ce3d7d44f3342107d884bfa90c966a")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "59e794d45697b360e18ba972bada0123")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "3b0845db57c200be6052466f87b2198a")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "5eca9bd3eb07c006cd43ae48dfde7fd3")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "b4f13cb081e412f44e99742cb128a1a5")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "4c660346451b8cf91ef50f4634458d41")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "11db24dc3f6c2145701db08625dd6d76")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "80dad3aad8584778352c68ab06250327")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "1227fe415e79db47285cb2689c93963f")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "8e084f489f1bdf08c39f98ff6447ce6d")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "08b2f2b0864bac1ba1585043362cbec9")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "4697843037d962f62a5a429e611e0f5f")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "10c4da18575c092b486f8ab96c01c02f")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "af205d729450b663f48b11d839a1c8df")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "0d3f91798fac6ee279ec2485b25f1124")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "4c3c7c067634daec9716a80ea886d123")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "d1e358e6e3b707282cdd06e919f7e08c")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "8c6ded4f0af86e0a7e301f8a716c4363")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "4c2d8bcb02d982d7cb77f649c0a2dea8")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "bdb662f765cd310f2a547cab1cfecef6")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "08ff5f7301d30200ab89169f6afdb7af")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "6eb6a030bcce166534b95bc2ab45d9cf")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "1bb77918e5695c944be02c16ae29b25e")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "b6fe77c19f0f0f4946c761d62585bfea")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "e9e7e260dce84ffa6e0e7eb5fd9d37fc")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "eced9e0b81ef2bba605cbc5e2e76a1d0")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "ef1772b6dff9a122358552954ad0df65")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "3b0c8ac703f828b04c6c197006d17218")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "652b906d60af96844ebd21b674f35e93")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "dc2f2f2462a0d72358b2f99389458606")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "762fc2665994b217c52c3c2eb7d9f406")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "cc7ed669cf88f201c3297c6a91e1d18d")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "cced11f7bbbffea2f718903216643648")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "24612f0ce2c9d2cf2b022ef1e027a54f")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "b06521f39153d618550606be297466d5")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "014842d480b571495a4a0363793f7367")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "c743a45e0d2e6a95cb859adae0248435")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "def5d97e01e1219fb2fc8da6c4d6ba2f")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "92cb737f8687ccb93022fdb411a77cca")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "a0d1395c7fb36247bfe2d49376d9d133")
          (list "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                "ab75504250558b788f99d1ebd219abf2")


          )))
    (let loop ((tests tests))
      (cond ((null? tests) #t)
            (else
             ;; (display "-----------\n")
             (let* ((test (car tests))
                    (text (car test))
                    (expected-digest (cadr test))
                    (actual-digest (bytes->hex-string (md5 text))))
               (cond ((equal? expected-digest actual-digest)
                      (loop (cdr tests)))
                     (else
                      (display "text: ") (write text) (newline)
                      (display "expected-digest: ")
                      (write expected-digest)
                      (newline)
                      (display "  actual-digest: ")
                      (write actual-digest)
                      (newline))))))))

;  (display "large file...\n")
;  (let ((p (open-binary-input-file "/home/seth/tmp/users.tar.gz")))
;    (write (md5 p))
;    (close-input-port p)
;    (newline))

  #t)



(define (multiple-sha1 times str)
  (let loop ((times times)
             (result ""))
    (cond ((= times 0) result)
          (else
           (loop (- times 1)
                 (string-append result str))))))

(define (digest-bit-test leading byte trailing expected)
  (let ((vector (make-bytevector (+ 1 leading trailing) 0)))
    (bytevector-u8-set! vector leading byte)
    (list (list vector expected))))



(define (test-sha-1)
  (let ((tests
         `(("" "da39a3ee5e6b4b0d3255bfef95601890afd80709")
           ("a" "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8")
           ("abc" "a9993e364706816aba3e25717850c26c9cd0d89d")
           ("message digest" "c12252ceda8be8994d5fa0290a47231c1d16aae3")
           ("abcdefghijklmnopqrstuvwxyz"
            "32d10c7b8cf96570ca04ce37f2a19d84240d3a89")
           ("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"
            "84983e441c3bd26ebaae4aa1f95129e5e54670f1")
           ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
            "761c457bf73b14d27e9e9265c46f4b4dda11f940")
           ("12345678901234567890123456789012345678901234567890123456789012345678901234567890" "50abf5706a150990a08b2c5ea40fa0e585554732")
           ,@(digest-bit-test 0 #x80 63
                              "c80b973c1157a7fe4f4150ad4c2a932494bf7bc7")
           ,@(digest-bit-test 0 #x40 63
                              "56b60a86c48bf35c2688b2b4e44e906c22221cf6")
           ,@(digest-bit-test 0 #x20 63
                              "f07dc15d139e20b569d018c517ea697434cb35ae")
           ,@(digest-bit-test 0 #x10 63
                              "cf3e842c69f06d3bc769367bc4b4f6e57b5496e5")
           ,@(digest-bit-test 0 #x08 63
                              "96429b7baa941f24306c1f9103fe2b454d1323b2")
           ,@(digest-bit-test 0 #x04 63
                              "f8a7c819fa7a7cc6c08376001f6f7c30dc52837d")
           ,@(digest-bit-test 0 #x02 63
                              "78ada92e4fefc60b100ee2af775b05520823b020")
           ,@(digest-bit-test 0 #x01 63
                              "9c8d8e5a31c9802b093c4116dfb0a23a311b8029")
           ,@(digest-bit-test 1 #x80 62
                              "7d43daa11204fc356565aa3c6d05aca04d9870c7")
           ,@(digest-bit-test 1 #x40 62
                              "e6b75e72075112399e5bf80a9a9cfbf6049eb5d2")
           ,@(digest-bit-test 1 #x20 62
                              "b445e64d88f2633490fa0eeb349d7fac9747c8f4")
           ,@(digest-bit-test 1 #x10 62
                              "038c8fd9d653e91399eebb87dfa2dd801b2b34a5")
           ,@(digest-bit-test 1 #x08 62
                              "dda4821e8441bc1ca66d18a2eaae4a6d0a495228")
           ,@(digest-bit-test 1 #x04 62
                              "499e5250d504f77dae8196d52b399ede52b19bc5")
           ,@(digest-bit-test 1 #x02 62
                              "cfee25e054425f4989f1e6efd3e1f3633ffd2d5e")
           ,@(digest-bit-test 1 #x01 62
                              "01f033f733ad52897a5f85743631d2c5a24df29d")
           ,@(digest-bit-test 2 #x80 61
                              "8f16cf5c70ab51ed9cdb44312eaead39c3ec2e52")
           ,@(digest-bit-test 2 #x40 61
                              "740b98b60ef34f120e38818427d72187cd5df4da")
           ,@(digest-bit-test 2 #x20 61
                              "d0723c0aff5876687a7b8cb6d0c45e6cdfe398c0")
           ,@(digest-bit-test 2 #x10 61
                              "bf2aa88116c9bba41e76c4835a8ddd0c2822a5fe")
           ,@(digest-bit-test 2 #x08 61
                              "6ebf3f3419c3ccc586344cf24e07050a8d5e5aaa")
           ,@(digest-bit-test 2 #x04 61
                              "1ded9734a2a6497f545537f50e162b707ebbecee")
           ,@(digest-bit-test 2 #x02 61
                              "e0150dd6726dcec7eecf0675a7fc998a98d43852")
           ,@(digest-bit-test 2 #x01 61
                              "c85602d666ec3b89ffbc8d496447113d15b15910")
           ,@(digest-bit-test 3 #x80 60
                              "11945ddd1210e9720335baa588911f0dd22a75f8")
           ,@(digest-bit-test 3 #x40 60
                              "3f085871e93d27ca79ba3cf549f4f14e925b47eb")
           ,@(digest-bit-test 3 #x20 60
                              "1eaf14b33c7cca699dad92c8514bdf68b01ccb40")
           ,@(digest-bit-test 3 #x10 60
                              "09444fabb51e6fe7d4452e79d1063b4a8e3e4d82")
           ,@(digest-bit-test 3 #x08 60
                              "87d02b5c01451b2e71917d51c078c522cecf3e0b")
           ,@(digest-bit-test 3 #x04 60
                              "2168e7ce44e725a2723542ef9bd06fda7a7e7c8f")
           ,@(digest-bit-test 3 #x02 60
                              "2e9c528e8e7f79ff214eb169d8a4c9762125373a")
           ,@(digest-bit-test 3 #x01 60
                              "80762ac3a2c6589b32fbd1b5edf9cf04b1b2215c")
           ,@(digest-bit-test 4 #x80 59
                              "ac293b9701fef4dddac98ea2b6024719642d26bb")
           ,@(digest-bit-test 4 #x40 59
                              "6c7dbcca072d9fb9096f0cb316f519da899173e0")
           ,@(digest-bit-test 4 #x20 59
                              "5b5e8b8fd142866535f68e59d4fe77cb05fd9ce1")
           ,@(digest-bit-test 4 #x10 59
                              "42875f6af7b7651d0c8385b425db3ffd99550102")
           ,@(digest-bit-test 4 #x08 59
                              "694d8bc576f66ade600cb6984ea7a7260cc44f14")
           ,@(digest-bit-test 4 #x04 59
                              "fe26d65a5424e8a8b3d3f5f1c34b9b5062baf56e")
           ,@(digest-bit-test 4 #x02 59
                              "3371e839a02aadad47c7cca1b2e2533f2767f422")
           ,@(digest-bit-test 4 #x01 59
                              "4168fa28936f4b1033a4e19d0a12da2ddd47c244")
           ,@(digest-bit-test 5 #x80 58
                              "24ffd42c1b342aa89e041b37755b337879ed7ca7")
           ,@(digest-bit-test 5 #x40 58
                              "1c0913ffd921bef41bd7462358e086227294b183")
           ,@(digest-bit-test 5 #x20 58
                              "48c97d9f0e0c7b29130646be6a56d4b2646edb88")
           ,@(digest-bit-test 5 #x10 58
                              "d6777e499284128d7f6e37d730d0e3fea173e438")
           ,@(digest-bit-test 5 #x08 58
                              "d032e3f7ef5669b263f474e3ccac671cdbbaf8ab")
           ,@(digest-bit-test 5 #x04 58
                              "97c80a4d5a89b79294c35cd6763b2e9c757545c7")
           ,@(digest-bit-test 5 #x02 58
                              "15595de8404b06aeb0ac4f5460741c5ec4618a6a")
           ,@(digest-bit-test 5 #x01 58
                              "e35eac18f548b2213043e2071e8a3328073e3b0d")
           ,@(digest-bit-test 6 #x80 57
                              "d9cfdc0aff96b9553cf7e3043d9276a434615e96")
           ,@(digest-bit-test 6 #x40 57
                              "0a99c997839e36b53bc61e11978d44052527891e")
           ,@(digest-bit-test 6 #x20 57
                              "f6d409b550c2ef3271d07d50ecf0ad2d88700619")
           ,@(digest-bit-test 6 #x10 57
                              "deed66bf0a4e4043d3811ea8ba0326704c334b0f")
           ,@(digest-bit-test 6 #x08 57
                              "2567b864fd878473495fd335aecea89fccdf2673")
           ,@(digest-bit-test 6 #x04 57
                              "eb8bff11acd9a2e62cbef9cd5a61697e5d5316d9")
           ,@(digest-bit-test 6 #x02 57
                              "c7f2d49aaa96200a373890516dc9320819416808")
           ,@(digest-bit-test 6 #x01 57
                              "b529d29a35a660a26b1d940eb48b3f29983f12c2")
           ,@(digest-bit-test 7 #x80 56
                              "55bb9c4f4175807789ab8c7e23cacfe2f8cf7031")
           ,@(digest-bit-test 7 #x40 56
                              "0e4fe8a0f3e5d3e415b93e85924ff96684edd04b")
           ,@(digest-bit-test 7 #x20 56
                              "0cc5775bef98969eaa8b1df3bedd1e305825d076")
           ,@(digest-bit-test 7 #x10 56
                              "1a455ad4ed941623b6a3fe01b16c1ab10c0af1a4")
           ,@(digest-bit-test 7 #x08 56
                              "bc112941c3736d8608572454bc3b9b81e4f00ecd")
           ,@(digest-bit-test 7 #x04 56
                              "38846e9960050e14e883b55d84db7f01215355af")
           ,@(digest-bit-test 7 #x02 56
                              "087894d777079923a1f335b5cff64eeb020b9831")
           ,@(digest-bit-test 7 #x01 56
                              "455bbde02d1e9648a3c5d6b2b0bbe09b1167ab9b")
           ,@(digest-bit-test 8 #x80 55
                              "e09044703f1c8f36b359cb4f88d9183e2626795b")
           ,@(digest-bit-test 8 #x40 55
                              "a7b4e0ed99c4ff63bf6008e07ac09c0c812bae1b")
           ,@(digest-bit-test 8 #x20 55
                              "3a11d6dda00db4c776e3fc7b6464679283e85f9a")
           ,@(digest-bit-test 8 #x10 55
                              "631c575338c15e3f7938f30619e17bd3f93b3c89")
           ,@(digest-bit-test 8 #x08 55
                              "ee5c5ea82de03cc13772a1d41520f5771a2d54ba")
           ,@(digest-bit-test 8 #x04 55
                              "6c9a8f934db6f888d6f9bd47de8d18e97aef836e")
           ,@(digest-bit-test 8 #x02 55
                              "a1332e2dd7913bd57af24f0f9179d73d72480809")
           ,@(digest-bit-test 8 #x01 55
                              "0dbcc21d171566f731595798084806d37e301461")
           ,@(digest-bit-test 9 #x80 54
                              "e6c51116961912f5314cffa544a6de2b24ab90d5")
           ,@(digest-bit-test 9 #x40 54
                              "e6250adf0aec03fa20ea071b0fbd35b069e706c5")
           ,@(digest-bit-test 9 #x20 54
                              "325b2fa3c59ce312460897453ff74318877c6b72")
           ,@(digest-bit-test 9 #x10 54
                              "dee1c0c3387d7d8c31867f1ba6af34026d49e1d7")
           ,@(digest-bit-test 9 #x08 54
                              "bf533f21e4e65065af6b3ee144683a80bf925d4b")
           ,@(digest-bit-test 9 #x04 54
                              "b9e4a4e179f9198a2abfefab564c27ea3c6d5f52")
           ,@(digest-bit-test 9 #x02 54
                              "9d892745d3179215ee1d2ea9898a3ab758dd63e9")
           ,@(digest-bit-test 9 #x01 54
                              "3506520468939295101a6ea95e427f762720dfe9")
           ,@(digest-bit-test 10 #x80 53
                              "4c8d7dc1dbf470b879abfc6db168899ae10f70bc")
           ,@(digest-bit-test 10 #x40 53
                              "c426ebaa58b03228871719aa5fcb30b05bf740c9")
           ,@(digest-bit-test 10 #x20 53
                              "5aa07142574f0aa5ae4fd7b5a51eb9aa63c1eb42")
           ,@(digest-bit-test 10 #x10 53
                              "56280bc7492bc80a2ad438e42c5c3956dc30e097")
           ,@(digest-bit-test 10 #x08 53
                              "967580251ac2a105e964c97da71a1feba94a68af")
           ,@(digest-bit-test 10 #x04 53
                              "158b4d9ba108126fc615a75c18228120d7d1969e")
           ,@(digest-bit-test 10 #x02 53
                              "119dab5498c9d2e0240c21b9eeff2d384f350855")
           ,@(digest-bit-test 10 #x01 53
                              "59c36c62ca45e8c5cb3e20747b19ee899e3dfb00")
           ,@(digest-bit-test 11 #x80 52
                              "a2d8594658b47709e739afda17e32174fc22d293")
           ,@(digest-bit-test 11 #x40 52
                              "c7646820d8315f820ee5daaf48a32e10cd942617")
           ,@(digest-bit-test 11 #x20 52
                              "46ebf4a676804a632551e82be4b57bd5ca435058")
           ,@(digest-bit-test 11 #x10 52
                              "941fee8affdce92c7b0c0c9f53935250d1606d2f")
           ,@(digest-bit-test 11 #x08 52
                              "4e79bf4bc6f098285196c9f624113476c002fc50")
           ,@(digest-bit-test 11 #x04 52
                              "1ef86e0eea541c8c374817bf6bf07278d3effefc")
           ,@(digest-bit-test 11 #x02 52
                              "c24be886919e9fec48294c5e2c7f7bbd5332565d")
           ,@(digest-bit-test 11 #x01 52
                              "6c99fcd7e1f6855eed92c2a7d1f3d3d9f6e8ad87")
           ,@(digest-bit-test 12 #x80 51
                              "e756da506bfc4a04465d5d7dd4c205e946485b22")
           ,@(digest-bit-test 12 #x40 51
                              "fd4e900de3342ee985823cbe347d7abff0085087")
           ,@(digest-bit-test 12 #x20 51
                              "cdb5cfe636c4f385e133d9422e38ae177ddf607e")
           ,@(digest-bit-test 12 #x10 51
                              "f40b90d9cfd60cd39c1cf1c5ed6a6be9b4c81ec5")
           ,@(digest-bit-test 12 #x08 51
                              "f82db7f598a7a746b90e7f0fafb95b69c98d9c39")
           ,@(digest-bit-test 12 #x04 51
                              "b9bed915e0015f533e4c47a65264bf7dddb2c7dd")
           ,@(digest-bit-test 12 #x02 51
                              "77b7cd2112666c5c49c9326ba18ea9b7e01912ce")
           ,@(digest-bit-test 12 #x01 51
                              "4c0cac3de798e7667519cbd8313562d32cb3f666")
           ,@(digest-bit-test 13 #x80 50
                              "32419e5fc2008472ac4f46b03e905dfbd8357b60")
           ,@(digest-bit-test 13 #x40 50
                              "d6b3831658fdd1185971ea835d071fa672220080")
           ,@(digest-bit-test 13 #x20 50
                              "71db19334f8216306f414d16abb810d5f887eec6")
           ,@(digest-bit-test 13 #x10 50
                              "4ef16fc64a42e04ba42070bd52c7b331a8d7b33c")
           ,@(digest-bit-test 13 #x08 50
                              "2773f7d0174eda2babc2e658d4112e1eceed7c4d")
           ,@(digest-bit-test 13 #x04 50
                              "3c9ec7c855fc076d4e93446b0b97881614ae69c4")
           ,@(digest-bit-test 13 #x02 50
                              "c05b6bccd76c842939c824bb7062837d606dc774")
           ,@(digest-bit-test 13 #x01 50
                              "7fc1463fc5e883a8783e83ba2aed9477140cefc7")
           ,@(digest-bit-test 14 #x80 49
                              "23ca389adc702949afdc8ce40b6ce7cb88a1da02")
           ,@(digest-bit-test 14 #x40 49
                              "25d9c3078e383115720d33841e04590e03fddb85")
           ,@(digest-bit-test 14 #x20 49
                              "5749378c96e41c974ab6eb82720f795ce2822ff4")
           ,@(digest-bit-test 14 #x10 49
                              "24f8e36845e10a853528181ad6eb1649657123b7")
           ,@(digest-bit-test 14 #x08 49
                              "45cb9c18da6f7ed31007f7f7ae1ae49ce685be67")
           ,@(digest-bit-test 14 #x04 49
                              "b26c1e83f82d92adc5787069ea64a97eaeb05449")
           ,@(digest-bit-test 14 #x02 49
                              "9adef89f604bcee1a318f0f9ab93460d3f03dd3b")
           ,@(digest-bit-test 14 #x01 49
                              "ca02bf109dd63bad6210e37dd0436f91ba94f33b")
           ,@(digest-bit-test 15 #x80 48
                              "b4da276ddfa7179f9e1557343d30fc553f61c485")
           ,@(digest-bit-test 15 #x40 48
                              "3e003a83b8694bcc857a628447dd83d4b1b4b255")
           ,@(digest-bit-test 15 #x20 48
                              "cfaa4c7f76dcea939513c08dfac97c7d350eba04")
           ,@(digest-bit-test 15 #x10 48
                              "004c40dd366f88f9fddd83771c05b48b66dcd70c")
           ,@(digest-bit-test 15 #x08 48
                              "bec1e4b13505fc884de92454b178481abc2bfa59")
           ,@(digest-bit-test 15 #x04 48
                              "e7ccbef62b98cb5597df9b14b8ac8f8b0c97f518")
           ,@(digest-bit-test 15 #x02 48
                              "7b0215faf7f0443be069c9278286165e26cbcf73")
           ,@(digest-bit-test 15 #x01 48
                              "108ce1122eb0c82633f976ca2efa026bba959308")
           ,@(digest-bit-test 16 #x80 47
                              "975c113ec6e5a2c1d6d79478a109040e2751d43f")
           ,@(digest-bit-test 16 #x40 47
                              "b61659219a809e80c7ed3d7846f6f3f3bee7089a")
           ,@(digest-bit-test 16 #x20 47
                              "b8278481a63bf09e1418081155ae7e5261e1a241")
           ,@(digest-bit-test 16 #x10 47
                              "ac46aeabe0a215d11130dfbb031a1222c055ec7e")
           ,@(digest-bit-test 16 #x08 47
                              "6531c0a7931c275b4f632ef8093919df9313c4f5")
           ,@(digest-bit-test 16 #x04 47
                              "c74538bd718108640db915639119f04d72c3f096")
           ,@(digest-bit-test 16 #x02 47
                              "f3144cc8d9a20e480e4e58da30acfee56d591cfd")
           ,@(digest-bit-test 16 #x01 47
                              "98556435801aa5697d810f8473630343a1b31a61")
           ,@(digest-bit-test 17 #x80 46
                              "da48390cd34e4b6128b0164bd47120e098ccc32e")
           ,@(digest-bit-test 17 #x40 46
                              "0e5758502fab4fac56076ecbc3e3434184cd81d1")
           ,@(digest-bit-test 17 #x20 46
                              "c6ad9bdfc1a609434a034987b95df0a95f16aa09")
           ,@(digest-bit-test 17 #x10 46
                              "6b7ede476cefdcfd23c99a2507c7289c703cc52a")
           ,@(digest-bit-test 17 #x08 46
                              "8ebed867ca66df27a46cfd0df20c836ef5a46c2a")
           ,@(digest-bit-test 17 #x04 46
                              "0d1a9561d0e873fede31413352a8c6877431662b")
           ,@(digest-bit-test 17 #x02 46
                              "71dc3fd33e02157b10fcba37be9424783098890e")
           ,@(digest-bit-test 17 #x01 46
                              "700bb77ff59f2f0ea7770106ea4ed5d45a86e2cd")
           ,@(digest-bit-test 18 #x80 45
                              "f657b3ed77505cdaffca43b21549a5d9426306c9")
           ,@(digest-bit-test 18 #x40 45
                              "661c99496aed852b153656ec8b26ef26366395ac")
           ,@(digest-bit-test 18 #x20 45
                              "5b95a6da71f704bf5a432d1987ebf996996043cc")
           ,@(digest-bit-test 18 #x10 45
                              "a97dd84f3159897b8369f7d7ccc0c1b32d2c397b")
           ,@(digest-bit-test 18 #x08 45
                              "891799a91b5d53171b3fc831b0aeb08969206365")
           ,@(digest-bit-test 18 #x04 45
                              "c9109757aa36e1856c660a2b52183ea5cf50f0d8")
           ,@(digest-bit-test 18 #x02 45
                              "4fcd24b654212348d52fdcf0c0942737f997e6fa")
           ,@(digest-bit-test 18 #x01 45
                              "d1397b8a4066e2168fd8aade3ee10ca203cf17cf")
           ,@(digest-bit-test 19 #x80 44
                              "349fbc1ccbf6069a09a8fc7995c069e32de61f0b")
           ,@(digest-bit-test 19 #x40 44
                              "a2cdc16fe423a24901918c97398d1b961cfc316c")
           ,@(digest-bit-test 19 #x20 44
                              "317843abbdc2b0953e4fa0904733f4242d7947e0")
           ,@(digest-bit-test 19 #x10 44
                              "0d7fff1ff47d64e3e48d7282b34bf6747284b415")
           ,@(digest-bit-test 19 #x08 44
                              "78f1be3f2ce991b8da39691a5604b9e635611da4")
           ,@(digest-bit-test 19 #x04 44
                              "f9abb648adb9141e575b8eb55d19a7c3d668e77e")
           ,@(digest-bit-test 19 #x02 44
                              "e4f6c06f5ee755af403815180f77b928e4825517")
           ,@(digest-bit-test 19 #x01 44
                              "7e012352ba1cc23980832c211bbe905b20500589")
           ,@(digest-bit-test 20 #x80 43
                              "bc8b0c78e3881eb468080ba61399c19a57e37722")
           ,@(digest-bit-test 20 #x40 43
                              "129b6f6ccd15ea61f479d5bab6d3af9a6ecbe8f8")
           ,@(digest-bit-test 20 #x20 43
                              "274cbeea6e5437de4e1c509a2d7898192d1190c9")
           ,@(digest-bit-test 20 #x10 43
                              "7d2e8445d5af45b4234c662d7365de0fde3f137a")
           ,@(digest-bit-test 20 #x08 43
                              "09778ae85fb61b38629ada752e43968cfdea9735")
           ,@(digest-bit-test 20 #x04 43
                              "ffac48b01bddd251e36ec2117fe4d7fb3e2dae88")
           ,@(digest-bit-test 20 #x02 43
                              "bf7f915990e45208e2115494c3c84b54e3f94d1a")
           ,@(digest-bit-test 20 #x01 43
                              "bcebae614742d8b4ea82342d41081b9477af1298")
           ,@(digest-bit-test 21 #x80 42
                              "38adb2132156ad53d301331100dc40e1a8b5061a")
           ,@(digest-bit-test 21 #x40 42
                              "ea743c69e66472733131f459195bec8af9226306")
           ,@(digest-bit-test 21 #x20 42
                              "847e47943d04b434a66bf9bd9b0703a1e480f9f5")
           ,@(digest-bit-test 21 #x10 42
                              "bb62ce0b4ddc49a425c9020c558ea08613c304ed")
           ,@(digest-bit-test 21 #x08 42
                              "2183fbe664beecdadc7a01eebbfb5948aab60a6e")
           ,@(digest-bit-test 21 #x04 42
                              "0b80d23df470bb06f2519e17c03002cc0ad4f2cc")
           ,@(digest-bit-test 21 #x02 42
                              "fddd3e02e14360f5db82d9791e42087b4fc86af2")
           ,@(digest-bit-test 21 #x01 42
                              "49bb25180763123ac51c3bc43c7ddbc32d778fe4")
           ,@(digest-bit-test 22 #x80 41
                              "4d34e126b4f06392a6648daa3dba9f48c128b9b1")
           ,@(digest-bit-test 22 #x40 41
                              "7d90eba93df3a8e8aaf26f42aa3b87246a4c2086")
           ,@(digest-bit-test 22 #x20 41
                              "b6919e57aabdd131f4b01a8ca3cd5dee4ec0ed85")
           ,@(digest-bit-test 22 #x10 41
                              "ab4cf9c77e130a221852fc35623dd8b056fa7a00")
           ,@(digest-bit-test 22 #x08 41
                              "9c2f76c3fb5ed565de41fd703227b420e9bbda64")
           ,@(digest-bit-test 22 #x04 41
                              "3ba8bc25929043f59402ace9c9e57758c2a1037d")
           ,@(digest-bit-test 22 #x02 41
                              "722073dd703e1e9ac88ad3d0f1e267479bcbfab3")
           ,@(digest-bit-test 22 #x01 41
                              "94d62ad63b4dfa23208ce1ea8f95f114f023c58a")
           ,@(digest-bit-test 23 #x80 40
                              "f9df96d378b1992100eed2df0d4d349a17f6eb93")
           ,@(digest-bit-test 23 #x40 40
                              "cd83248d90959c86d383c0e9a7a722aa8c9d4688")
           ,@(digest-bit-test 23 #x20 40
                              "bc548a565154a6694995b5bfa59423d65f3a8981")
           ,@(digest-bit-test 23 #x10 40
                              "e8a080ee63161372523fb08370f525fef7535c43")
           ,@(digest-bit-test 23 #x08 40
                              "203b3667f5227b2ed4ee398a9078e840b25289f4")
           ,@(digest-bit-test 23 #x04 40
                              "9196a67c90584cc300100bbcff5ddc6fd71a2405")
           ,@(digest-bit-test 23 #x02 40
                              "7d540dc309a2597bfd5b5ae0c4dcd926e49f4920")
           ,@(digest-bit-test 23 #x01 40
                              "3060e082b61e4c6ec0d4030c17817453d69d9285")
           ,@(digest-bit-test 24 #x80 39
                              "e1bf28ea2645c40bf120b26d7ab4fc5a1ec254a8")
           ,@(digest-bit-test 24 #x40 39
                              "9baa92bca186e8c5948cae54f88d09f2aec14d7f")
           ,@(digest-bit-test 24 #x20 39
                              "18ba5ca9513b130ce92453ff36a5a0d2faa9a476")
           ,@(digest-bit-test 24 #x10 39
                              "dbed362f2b76bbf6fa58e18d29397a95f0fa0112")
           ,@(digest-bit-test 24 #x08 39
                              "e2e1a4bbded9d5fa2da200b233e2186630396f57")
           ,@(digest-bit-test 24 #x04 39
                              "4211dc41833e093510d395a5b14bb96d64c38d92")
           ,@(digest-bit-test 24 #x02 39
                              "e726fcce510df503ce82640ac1f7ab28c19d7c46")
           ,@(digest-bit-test 24 #x01 39
                              "d702cbe5864f3b07affc43367136d69a1f2b8d42")
           ,@(digest-bit-test 25 #x80 38
                              "54b17ee781a17edc3b4c420d78f83c7c978f3cab")
           ,@(digest-bit-test 25 #x40 38
                              "49c732af40f4a74d780d4250267706f7fb1a6c47")
           ,@(digest-bit-test 25 #x20 38
                              "17ddce095e7d0cfd5f795ab462edfcc116b7e532")
           ,@(digest-bit-test 25 #x10 38
                              "d0c2b1bf2f99f8d107800a78c414701fc1a842f6")
           ,@(digest-bit-test 25 #x08 38
                              "43027a3615d6c7a83d14581535fbacaa36572add")
           ,@(digest-bit-test 25 #x04 38
                              "dd40216a698a881b04541e2405cf43d38bd62d61")
           ,@(digest-bit-test 25 #x02 38
                              "a14ed13406e4751df32f0c6f1bd82f03b0d335dd")
           ,@(digest-bit-test 25 #x01 38
                              "30600629a515ea95fadaa13e33cc4f1c6d2e7ee5")
           ,@(digest-bit-test 26 #x80 37
                              "d8003007e44d39e16cbf0a0b7bb72e523705ff35")
           ,@(digest-bit-test 26 #x40 37
                              "090919153f6f2b0b7414013b00f29ba16c3f6ed4")
           ,@(digest-bit-test 26 #x20 37
                              "a9f90b4f50c93ec61148d8a0ac41b10cbbd42c51")
           ,@(digest-bit-test 26 #x10 37
                              "56f121a340de79356f95be7e371c4214643a92fd")
           ,@(digest-bit-test 26 #x08 37
                              "ccfa24cfd91e151aa67b88120b6e3e6f252f41be")
           ,@(digest-bit-test 26 #x04 37
                              "df66af08c35c0ddd6faa088cef132466022f1cad")
           ,@(digest-bit-test 26 #x02 37
                              "e081c6cc8e45eb60ec5ef41f56255bac13546d06")
           ,@(digest-bit-test 26 #x01 37
                              "aec50b2fefd190011516392b43b61e86c9f4f779")
           ,@(digest-bit-test 27 #x80 36
                              "d9d04dcdf5855c520bf87accf7c86ad48e648935")
           ,@(digest-bit-test 27 #x40 36
                              "21a6a0044b5f5bffa8245672eb0c0ac70caf9757")
           ,@(digest-bit-test 27 #x20 36
                              "eb9b20c75d2de45b58049d0a7b7ac42a21e14161")
           ,@(digest-bit-test 27 #x10 36
                              "84569c7e024fda33562804ed1f1959cd60c1537e")
           ,@(digest-bit-test 27 #x08 36
                              "d6a143bbe76833ddba3b2f2bd8481c1f0fefa59f")
           ,@(digest-bit-test 27 #x04 36
                              "26d802656e0e29eaa263cd58ff39cd8d08567a1c")
           ,@(digest-bit-test 27 #x02 36
                              "a8a2791d33cc80a935f07744012667e989e19805")
           ,@(digest-bit-test 27 #x01 36
                              "1b2ac35a2425e935d1b4398d72313306586e77db")
           ,@(digest-bit-test 28 #x80 35
                              "a89c88dd8d3057bb49344ba9d7d274986bdac954")
           ,@(digest-bit-test 28 #x40 35
                              "48d0f840967af3f7f67162b04467996f7e0248ad")
           ,@(digest-bit-test 28 #x20 35
                              "1e2355a26e6e96391a6cbb14f41790743eb65d3d")
           ,@(digest-bit-test 28 #x10 35
                              "6580e48e6e1f51cc4fa2b65d74c8183b59f69a6a")
           ,@(digest-bit-test 28 #x08 35
                              "0c4e898bb1cd11c1fbe41a434a2a73697e2a39ef")
           ,@(digest-bit-test 28 #x04 35
                              "f4261c323cefaee5cda5f20275bfb4b62d8206b8")
           ,@(digest-bit-test 28 #x02 35
                              "1a4788a361cecced29efeac51ff8f6bb68dfded4")
           ,@(digest-bit-test 28 #x01 35
                              "2c414b96a80b2be5d1a6e1a29dd24e68fb7ef776")
           ,@(digest-bit-test 29 #x80 34
                              "5b8c03ef6ccbf12df96f9d46def25c497eb8e4ef")
           ,@(digest-bit-test 29 #x40 34
                              "509a557f6d594b365626ec8a836468def7ba1970")
           ,@(digest-bit-test 29 #x20 34
                              "4a5bb3d4b6336d2bc02e60bda63195f07a767b62")
           ,@(digest-bit-test 29 #x10 34
                              "4b52399a9fe907cdbe8370f1f7f28f8884db5b70")
           ,@(digest-bit-test 29 #x08 34
                              "310775d674a5a05f9f6fb70cddd3c9ef68a6ed8d")
           ,@(digest-bit-test 29 #x04 34
                              "10f543f139a0f6bc2b8051974222d4870c79a050")
           ,@(digest-bit-test 29 #x02 34
                              "890e02391b11fab9602f0ee18b0ca0a34af425f5")
           ,@(digest-bit-test 29 #x01 34
                              "9dea28ec04e1a9bdde165fb81b9e123256cbb876")
           ,@(digest-bit-test 30 #x80 33
                              "4972106ba1ecefd0c55068120585ef2d94239cbe")
           ,@(digest-bit-test 30 #x40 33
                              "787f7049bb78e3712e5b9b4f447db38d2a42da67")
           ,@(digest-bit-test 30 #x20 33
                              "3e8e2c84de92183c61419be04ff01a26acef9ea9")
           ,@(digest-bit-test 30 #x10 33
                              "dcf8e1edb48f42331f5dd50c06269f51a1c7b2d5")
           ,@(digest-bit-test 30 #x08 33
                              "bdeaedc13e7010849d258aa7c9be0206f95c853a")
           ,@(digest-bit-test 30 #x04 33
                              "36aa3434bad394718b21acdf6ec2526f51627948")
           ,@(digest-bit-test 30 #x02 33
                              "e6ee7041303a55d95ba3093507f58f5da10b8254")
           ,@(digest-bit-test 30 #x01 33
                              "380cc98bd9c83aa09dc30db59c3029a3ecba5c1c")
           ,@(digest-bit-test 31 #x80 32
                              "9b928d8148f4114f158e46824e766ff2a7a62b34")
           ,@(digest-bit-test 31 #x40 32
                              "f33fac77f2a2036c6116d19efbcf07b1c0f38fad")
           ,@(digest-bit-test 31 #x20 32
                              "1ca9b7e149c031ee02c254182a90b62547db6aa4")
           ,@(digest-bit-test 31 #x10 32
                              "b1db2b2305b65a1421b7084a78f97ff2d227865b")
           ,@(digest-bit-test 31 #x08 32
                              "bac51faaadf6127971f210e8eddbe17e99e17993")
           ,@(digest-bit-test 31 #x04 32
                              "d26c92ead620313a4b21cdacf0f32287bfd21f74")
           ,@(digest-bit-test 31 #x02 32
                              "d7a7b4d4d0ca22eec9d2e7cb1d8fde422225483c")
           ,@(digest-bit-test 31 #x01 32
                              "f936af09029b1e14cddb9387e8362eb29a436a0b")
           ,@(digest-bit-test 32 #x80 31
                              "c335854a19d6b6b099aa4145e1cd9658dac4b60f")
           ,@(digest-bit-test 32 #x40 31
                              "b8ea6301ba799caedf54ded2f4e04253e1831d8f")
           ,@(digest-bit-test 32 #x20 31
                              "6bea287617579a5b351cddc18d14e1cf0e695250")
           ,@(digest-bit-test 32 #x10 31
                              "ad6c45b1cd47b6c705d3b75ccf90ac0d1915686c")
           ,@(digest-bit-test 32 #x08 31
                              "6eb575e8412d916df0ac6ffdbb5cc79eba83dce5")
           ,@(digest-bit-test 32 #x04 31
                              "226d1ac28ab39b62d24e2b80baf4d9dba0b1c755")
           ,@(digest-bit-test 32 #x02 31
                              "a109d1d9cfd7800d310bcba64e2f1300c7367734")
           ,@(digest-bit-test 32 #x01 31
                              "37b7dcf21e0e183a9a86170997df242a84a85ff7")
           ,@(digest-bit-test 33 #x80 30
                              "c3e28649f4c02f21c4cd5d8e27d4e3d67016c2ac")
           ,@(digest-bit-test 33 #x40 30
                              "79889011edc1ee59541fd593b24b4aa905bd17c4")
           ,@(digest-bit-test 33 #x20 30
                              "4e1d04704b703757389b3c91fb05d2aa7e2d9043")
           ,@(digest-bit-test 33 #x10 30
                              "a86cb3bfb25ae2f28c063e6b88cffd8c37850cf6")
           ,@(digest-bit-test 33 #x08 30
                              "093ffb88a184ea1e0f81e244e40a13449cec646e")
           ,@(digest-bit-test 33 #x04 30
                              "ec7d66da9c3fa2cca0365e2ad3e2a78bd59db1bb")
           ,@(digest-bit-test 33 #x02 30
                              "f8efa4b89684a900e6a7dfbd8e76834074d3c653")
           ,@(digest-bit-test 33 #x01 30
                              "2b95691be17bfeac4911ed9c629b47dfa8729e1e")
           ,@(digest-bit-test 34 #x80 29
                              "93a743fc2be88424d24b459475cf7579b6fe82d9")
           ,@(digest-bit-test 34 #x40 29
                              "c68e51da0171770dfa3fa96234aef2f53bc493bf")
           ,@(digest-bit-test 34 #x20 29
                              "3b74cc5d74226619e37f01ee83d2b48540cd734f")
           ,@(digest-bit-test 34 #x10 29
                              "aa08ccb4a80fa396b4e8d60f679eec506b7b9a65")
           ,@(digest-bit-test 34 #x08 29
                              "a11e372982163ebfc67412b34b63d86fc3e83067")
           ,@(digest-bit-test 34 #x04 29
                              "605312fb9dcafe0794773c6016e428efa6f762d7")
           ,@(digest-bit-test 34 #x02 29
                              "112984bb5f7e77d2838a44d9166a01eb339e3c11")
           ,@(digest-bit-test 34 #x01 29
                              "2338180643fc2a6f60a8cb718dac7e1639f57351")
           ,@(digest-bit-test 35 #x80 28
                              "f14b90992f4d5a1243bfc5a63c94c49590c46b68")
           ,@(digest-bit-test 35 #x40 28
                              "ffb6ad250782ae8c16f9a610973c77dfef095f1c")
           ,@(digest-bit-test 35 #x20 28
                              "d1b731d084179c8d12e5365eff7100bbeca13427")
           ,@(digest-bit-test 35 #x10 28
                              "96730c09f3ab3e06bbd64a4a42850877e7ae4293")
           ,@(digest-bit-test 35 #x08 28
                              "58f5585f58985eb95c7a3ef8561d5ffbbb60a6a9")
           ,@(digest-bit-test 35 #x04 28
                              "89de54f734d3a6a3a2e05d9c58c630a9c25d4981")
           ,@(digest-bit-test 35 #x02 28
                              "5ab0d562986a32a334eca6cc5b21433c18b7819a")
           ,@(digest-bit-test 35 #x01 28
                              "7e3d6dfe5a25fcc4a340d9cc5a998f0614688176")
           ,@(digest-bit-test 36 #x80 27
                              "18977350d746c049a89b49814682fbc8dac9e28c")
           ,@(digest-bit-test 36 #x40 27
                              "93f5dee808872b1acb23f7cf21b5c7cb5ec7fc52")
           ,@(digest-bit-test 36 #x20 27
                              "015100cae85185f42a48b70eb95ab0de9ae118a4")
           ,@(digest-bit-test 36 #x10 27
                              "d12e261473bf1c68a961f34334df31e164cd73a8")
           ,@(digest-bit-test 36 #x08 27
                              "d74fdfb0d814771e7b4b955c268d15b5aa99d72f")
           ,@(digest-bit-test 36 #x04 27
                              "ced846e7527c74653cd30d80e8097bbd8c29bca6")
           ,@(digest-bit-test 36 #x02 27
                              "77a55e00e669e34fd0f9a16f2d16defc900ea466")
           ,@(digest-bit-test 36 #x01 27
                              "281f0f08687150f51218b5f9119ca082d4f3423e")
           ,@(digest-bit-test 37 #x80 26
                              "404ba3e3275f06e9fac48c8d92f51e9af4df55d3")
           ,@(digest-bit-test 37 #x40 26
                              "97eb1bc7b8d1dfa3549b8a2e07595676163d09d3")
           ,@(digest-bit-test 37 #x20 26
                              "c099c6b7a8352beb1262ecd02782bf4428ff69c4")
           ,@(digest-bit-test 37 #x10 26
                              "9d77e37ff377a4c222e7c81003051cd4da9fe9eb")
           ,@(digest-bit-test 37 #x08 26
                              "c59da8793931e9e4b930e100cdbb4c36ebf3eca6")
           ,@(digest-bit-test 37 #x04 26
                              "bb6c8b6f3896dd85f33740404a834920e8aea444")
           ,@(digest-bit-test 37 #x02 26
                              "dd366c91de61d6b1581472c950c6d1223bc67cbc")
           ,@(digest-bit-test 37 #x01 26
                              "66071311db52813c4f7f6538b28ed8ea38002555")
           ,@(digest-bit-test 38 #x80 25
                              "7fcb5e982d0475d029869f3947c25b1a55755589")
           ,@(digest-bit-test 38 #x40 25
                              "de0ed84a276aa030b8ea70dc3c9cf295adccf007")
           ,@(digest-bit-test 38 #x20 25
                              "e6bed540761c6fda38ac6db6661d676df7afc71e")
           ,@(digest-bit-test 38 #x10 25
                              "829eade04c28286ab3c589069d58b7226ebd15a3")
           ,@(digest-bit-test 38 #x08 25
                              "794f0ff33702723e8e6981f006632062ccc05d15")
           ,@(digest-bit-test 38 #x04 25
                              "8afa385dbbdee2bfa4fdcf01d047f3a131e08a67")
           ,@(digest-bit-test 38 #x02 25
                              "1e86c19a1a91270275c3e6e41ced9b7d4ff81133")
           ,@(digest-bit-test 38 #x01 25
                              "3abbd0ad167cee74d94ca4593b3c2ea74b9246c7")
           ,@(digest-bit-test 39 #x80 24
                              "6ed914ae39347e3a9a96080aafbd497e33701866")
           ,@(digest-bit-test 39 #x40 24
                              "05ce2dd4ab125a0e913dfd514d9dd935b8dd3d62")
           ,@(digest-bit-test 39 #x20 24
                              "7c577206c0f66b2df7adb657b6ad528144913b26")
           ,@(digest-bit-test 39 #x10 24
                              "1d43abcfcae5e92a06796e7a751c8f569d88f7fc")
           ,@(digest-bit-test 39 #x08 24
                              "7b4ccffd7e64ab1d7816ca43886efe58cde89b7b")
           ,@(digest-bit-test 39 #x04 24
                              "0f3d83bf05e509f3939b23c71d8e518e38a6c3c1")
           ,@(digest-bit-test 39 #x02 24
                              "223cb390ebbe15c117225a39dd45d7a9fc5b1d7b")
           ,@(digest-bit-test 39 #x01 24
                              "96aac2f7dfa3ff387c3e12a53d8c51f93d362a44")
           ,@(digest-bit-test 40 #x80 23
                              "946f7992ef21d07b55b8ccccb4840834cfc52492")
           ,@(digest-bit-test 40 #x40 23
                              "1254ceda60c0dd56a06395d4b78a07a9a623cf8d")
           ,@(digest-bit-test 40 #x20 23
                              "4548994e655b8b63ec7761015c46bdad46bbca94")
           ,@(digest-bit-test 40 #x10 23
                              "a4da64e02bb6fc6783254cce92f4c28d79753f25")
           ,@(digest-bit-test 40 #x08 23
                              "8a213bdc144a8b6a4c518c1c22a425d3f21fec85")
           ,@(digest-bit-test 40 #x04 23
                              "768b6b9397ce32864c5ee1a90eaf42d0489cdbe6")
           ,@(digest-bit-test 40 #x02 23
                              "f9313fb67ee62d61cb35b58a67f2668e8996a77f")
           ,@(digest-bit-test 40 #x01 23
                              "56f8dbf4ccf51ad0bfa042b7b2410346bc138e36")
           ,@(digest-bit-test 41 #x80 22
                              "dccb6932c8aae2efa72efaf9aafb4804fa28aeda")
           ,@(digest-bit-test 41 #x40 22
                              "2061cdbfe1d8a55c9f9d8dd49a8366139327ecd6")
           ,@(digest-bit-test 41 #x20 22
                              "956c4cd7f0e47501f07fd6694adee481a0a706d7")
           ,@(digest-bit-test 41 #x10 22
                              "b0a22915b6d5990eae90ad3e550f9294d18f6e90")
           ,@(digest-bit-test 41 #x08 22
                              "21286ba23811271a072a75a3a7ecf33f186533b6")
           ,@(digest-bit-test 41 #x04 22
                              "ba591b8fbd5c8dfae091ad997af7d58d56656356")
           ,@(digest-bit-test 41 #x02 22
                              "34522d926dc21f0997400b42927ebf1cb291b961")
           ,@(digest-bit-test 41 #x01 22
                              "a0aa85260b30da9d658413214918f7bea7e3bc15")
           ,@(digest-bit-test 42 #x80 21
                              "696e36b391191dba094532f9f61c9432ac42bb36")
           ,@(digest-bit-test 42 #x40 21
                              "032498a6ec908f466125e7a8a0bdc928199b5111")
           ,@(digest-bit-test 42 #x20 21
                              "2ce9d0ca449332dd88531128a549ac5ab50c38c5")
           ,@(digest-bit-test 42 #x10 21
                              "4970cddb596a876a39f9d273cf718961603d2190")
           ,@(digest-bit-test 42 #x08 21
                              "a09dab62bc9fd4a646b346398ce8665a0bb8108f")
           ,@(digest-bit-test 42 #x04 21
                              "9ae7485721299a29977998d5480505ca77bcdc40")
           ,@(digest-bit-test 42 #x02 21
                              "61bdd16d7695cdbc7e09c8acc87c2eb64851cb39")
           ,@(digest-bit-test 42 #x01 21
                              "1df7548a0cad64526a030bc9bfc5626d17479831")
           ,@(digest-bit-test 43 #x80 20
                              "e6d75b4731632b08a9ec48332e3cc9c9e5f9994d")
           ,@(digest-bit-test 43 #x40 20
                              "29de6bd404bf0fe6c284c578b017a6e713f59ecb")
           ,@(digest-bit-test 43 #x20 20
                              "55895e9a39f68680ba67f2cbb4eea698496cb950")
           ,@(digest-bit-test 43 #x10 20
                              "85fcba107c2156453c42cffc30c63b40c9cafdaf")
           ,@(digest-bit-test 43 #x08 20
                              "a9bb529ec301805aa8acbe8389ad48e0385162bf")
           ,@(digest-bit-test 43 #x04 20
                              "154f31beafd8730a343c80051a2f9c149a3dd4d5")
           ,@(digest-bit-test 43 #x02 20
                              "f303e5e88c37c0eff29180b372e00b9a8dc7ddb7")
           ,@(digest-bit-test 43 #x01 20
                              "a3b287d882127b00f7a723db405298a460c73796")
           ,@(digest-bit-test 44 #x80 19
                              "4c8100f4e5629fb2cc6324d77737569522e5c775")
           ,@(digest-bit-test 44 #x40 19
                              "c1b6d177e1d224b3fb8b7719263cf6f2fa211323")
           ,@(digest-bit-test 44 #x20 19
                              "7eaf07e00bb7fd8f18e06be05a137e314ba34bf2")
           ,@(digest-bit-test 44 #x10 19
                              "0c2aae56115be62930c4ae04b4fd152f64ed409c")
           ,@(digest-bit-test 44 #x08 19
                              "d676e0f5de53fdac16b35d06bb777599e838a1e0")
           ,@(digest-bit-test 44 #x04 19
                              "c500095e6f880659eec666ff7f5bc37e39fabc2c")
           ,@(digest-bit-test 44 #x02 19
                              "d7e6eba584da5cd273d2e154330229b417f34361")
           ,@(digest-bit-test 44 #x01 19
                              "66bc10e7f84332a968d2e9e0cb79c68643ececf9")
           ,@(digest-bit-test 45 #x80 18
                              "8ef22381d402646d3e102fb413703a8277d2b565")
           ,@(digest-bit-test 45 #x40 18
                              "b449114bd723e547dcac5ca2d88bcec690254f98")
           ,@(digest-bit-test 45 #x20 18
                              "2647472c0c4875cda5e266acbe6b2836539ab432")
           ,@(digest-bit-test 45 #x10 18
                              "29d6e52268abdf244fe662dba33ab9435ee66d1c")
           ,@(digest-bit-test 45 #x08 18
                              "4f0e93f97bbfc3395210d426f08d88d0c2bfd599")
           ,@(digest-bit-test 45 #x04 18
                              "6d76eb4c96f011e859ea81b136870784c70722f3")
           ,@(digest-bit-test 45 #x02 18
                              "4182d12c128bd5ee2ec8851c943b21720a6ecc32")
           ,@(digest-bit-test 45 #x01 18
                              "0db22b512839c314a0235b245b66eccc4fb29176")
           ,@(digest-bit-test 46 #x80 17
                              "9f9f449fef08de2a3f202b481c5b9b9690938b82")
           ,@(digest-bit-test 46 #x40 17
                              "6fd1ee49a36f67407f36b193df20fb0ee9ebb3bf")
           ,@(digest-bit-test 46 #x20 17
                              "178c4e21e76a1718a4263e1dc9197d76345c1756")
           ,@(digest-bit-test 46 #x10 17
                              "c6519dc7593847544fdc38d2f024ed55a66baed5")
           ,@(digest-bit-test 46 #x08 17
                              "bdf4a387201ca0d1d2ffdee174f913adea999cc7")
           ,@(digest-bit-test 46 #x04 17
                              "549c43613ac1743e5b4e7a9a506f665b11cae4cf")
           ,@(digest-bit-test 46 #x02 17
                              "0e59307c457a57eb30d5a9e9d797ca6b64d5f191")
           ,@(digest-bit-test 46 #x01 17
                              "9d15c38b6220c7f41efa2c8b6a2dd1c17a19c109")
           ,@(digest-bit-test 47 #x80 16
                              "cba55f53bbcb90e739b2344c8e8508d631ca429e")
           ,@(digest-bit-test 47 #x40 16
                              "86cf8c99f8996dc0db12e004721a781533b33f68")
           ,@(digest-bit-test 47 #x20 16
                              "5e735505672a66959bcad565f6dd9b4d311923ba")
           ,@(digest-bit-test 47 #x10 16
                              "e15c395b45066d50f2f25b8f85dec3791281ba0a")
           ,@(digest-bit-test 47 #x08 16
                              "cdd485f608fa7bf001f59ba9daaf266c50fcfa98")
           ,@(digest-bit-test 47 #x04 16
                              "94beeac05f3e5a6fb2cf1cb1229b230542451864")
           ,@(digest-bit-test 47 #x02 16
                              "d5481f60fcef55d8c101fbba7c054d88e37637f9")
           ,@(digest-bit-test 47 #x01 16
                              "4843ca5c5a803061d2ffccd73faeee578ab13dbd")
           ,@(digest-bit-test 48 #x80 15
                              "d479fc21c0a351ddede3e79541b4e1b5f9542fd6")
           ,@(digest-bit-test 48 #x40 15
                              "e5f1ee88df160fe503195104ac809e78f1697049")
           ,@(digest-bit-test 48 #x20 15
                              "1d37721790245f4182292f058930c37b4a9ce7ee")
           ,@(digest-bit-test 48 #x10 15
                              "44d614ada253c44bc5fdef6fa7dff5792e621698")
           ,@(digest-bit-test 48 #x08 15
                              "745f03bfb20ef8cbd663767e3326ad6b1b4fc679")
           ,@(digest-bit-test 48 #x04 15
                              "9a88a295dce2b8e8e48fbf7be3ce55b33635a97f")
           ,@(digest-bit-test 48 #x02 15
                              "09909637ce971b7015281b85210b30c12f76e09e")
           ,@(digest-bit-test 48 #x01 15
                              "f0e9ee70866abf4f2aaeb307663032214b976f27")
           ,@(digest-bit-test 49 #x80 14
                              "c19991c30080994cf78dd0b8cbb59dce2c64079a")
           ,@(digest-bit-test 49 #x40 14
                              "29fe5880518565977d40dd45aec19bae84515e81")
           ,@(digest-bit-test 49 #x20 14
                              "0fba86225438a82db0f2dd6d655d1d85a5ad3b14")
           ,@(digest-bit-test 49 #x10 14
                              "ae8e67d9f7a3cd1d5b883eb4988bd751eda4f6a4")
           ,@(digest-bit-test 49 #x08 14
                              "dfb8da261c6cf4e55156f9cc6c760fc236479614")
           ,@(digest-bit-test 49 #x04 14
                              "da9e82445fab469b724230008e70c96cadd60239")
           ,@(digest-bit-test 49 #x02 14
                              "3820c5054068282169d937a1b01c2c5206012bee")
           ,@(digest-bit-test 49 #x01 14
                              "c733a544f82a013c0f1a26d4a040357d2eaa4c52")
           ,@(digest-bit-test 50 #x80 13
                              "5f3cd7855c356b7587e8dedaf9ed0262aabee7c4")
           ,@(digest-bit-test 50 #x40 13
                              "e740eaeeca9a5e5c59578e6d89674ef1a56970e1")
           ,@(digest-bit-test 50 #x20 13
                              "a51b76e73bfbdbf980bf6fea495a3cfb7d25809a")
           ,@(digest-bit-test 50 #x10 13
                              "a6e554f7e2d4ff1ca71395ba093bdd19a3661639")
           ,@(digest-bit-test 50 #x08 13
                              "5bd9f14f7985cb09638feaf2cd5389a9a18be557")
           ,@(digest-bit-test 50 #x04 13
                              "f65adf18a93a5b67dec169d2a73f4ae1673fc773")
           ,@(digest-bit-test 50 #x02 13
                              "73f8b85993f0d3cb12aba034fdba2f4d6e3e168b")
           ,@(digest-bit-test 50 #x01 13
                              "5055e365875b5e91c91b87619e3fc079add4deeb")
           ,@(digest-bit-test 51 #x80 12
                              "c8fcb6653d648a5162c53d624dc0e85745769bb4")
           ,@(digest-bit-test 51 #x40 12
                              "3d7c3ea505167f9fbd99d18a5b615ecfd9c26d15")
           ,@(digest-bit-test 51 #x20 12
                              "061bd5cf62919a1b2e1163520436e2aa552be242")
           ,@(digest-bit-test 51 #x10 12
                              "6a0fe1b5f651e7ca327d0083ba65e6f8fc42337b")
           ,@(digest-bit-test 51 #x08 12
                              "338bc5b38bba52b80a2bfe88fcf95e925a9702d8")
           ,@(digest-bit-test 51 #x04 12
                              "f510d70693808ed495b06d86a784627de4d87672")
           ,@(digest-bit-test 51 #x02 12
                              "ad0d2471322d2c27db1f0babc3c292cd3ab3239c")
           ,@(digest-bit-test 51 #x01 12
                              "93ff72c5d4a53fe0823f4f392d5407b298c5adbb")
           ,@(digest-bit-test 52 #x80 11
                              "ef17405e6d26269f503eeea3504fc9280d2603b9")
           ,@(digest-bit-test 52 #x40 11
                              "e5036dd48a55451d8212a27a85fe5779c30964fe")
           ,@(digest-bit-test 52 #x20 11
                              "10b74a030d16992f2df906256858186d882554a6")
           ,@(digest-bit-test 52 #x10 11
                              "7181dc401250f84aae4aa1ffb94a89acd98e5fac")
           ,@(digest-bit-test 52 #x08 11
                              "441c9327f5dc2907fd3c85c01d094fb2727aa6af")
           ,@(digest-bit-test 52 #x04 11
                              "068a13fd27dce7b9bde20ebf9c28c1227eda5f6f")
           ,@(digest-bit-test 52 #x02 11
                              "37273bd0e062b21349798c89b95a6e74bf58821a")
           ,@(digest-bit-test 52 #x01 11
                              "0a5a8fdbaf2101414d23860287a37c0582641646")
           ,@(digest-bit-test 53 #x80 10
                              "05b6211a7398032d2cc58c9bc3fa1a66d70c1e83")
           ,@(digest-bit-test 53 #x40 10
                              "0ffc3b8756c5d5765fd64b2eb9f065b2caf06c5a")
           ,@(digest-bit-test 53 #x20 10
                              "992e5dd62bf677cc7439c10c73fbba5b61a6c8e5")
           ,@(digest-bit-test 53 #x10 10
                              "385ce73875a2150c12d1558b3b89a53ba780a9ba")
           ,@(digest-bit-test 53 #x08 10
                              "c5dc05f37c48d5a299806c2ab3d3e992d9994a09")
           ,@(digest-bit-test 53 #x04 10
                              "d53b026111bcaf9c8ff3255709850e153ec7f149")
           ,@(digest-bit-test 53 #x02 10
                              "40cef784a88c9da3355c80c9b220b12b578f8430")
           ,@(digest-bit-test 53 #x01 10
                              "9e83dbd01b91ee6a3615334d3530eb52fc6d79af")
           ,@(digest-bit-test 54 #x80 9
                              "bd2a8e4a91df23662428c4fddb93d665aae02bef")
           ,@(digest-bit-test 54 #x40 9
                              "06ea50eee8ee904d4bcab484c7a0d57f1e686d3c")
           ,@(digest-bit-test 54 #x20 9
                              "bec01bb7f8bdbf144dfe0b3dd05427666f1daa00")
           ,@(digest-bit-test 54 #x10 9
                              "3f281d9f9288c3284d6d614606ace0288fa46fde")
           ,@(digest-bit-test 54 #x08 9
                              "8b3b8b96a5af2fea5ded2eed9dbf87ac28872287")
           ,@(digest-bit-test 54 #x04 9
                              "fe60132b70dd243b661e7851828c79708cadfcf9")
           ,@(digest-bit-test 54 #x02 9
                              "b5ed866e9bcca4e703fbb30a1e4924d72faf4d50")
           ,@(digest-bit-test 54 #x01 9
                              "a0a55ec19e35fd0870bbc90a7cf333ade724de25")
           ,@(digest-bit-test 55 #x80 8
                              "0cbc0062c25f233616de607a0a54b6d16b5a016f")
           ,@(digest-bit-test 55 #x40 8
                              "7fb304f334da910fbbb412ed6a41cbee66a0093a")
           ,@(digest-bit-test 55 #x20 8
                              "22032f4e752e7d5d26db09991ef731e87e118680")
           ,@(digest-bit-test 55 #x10 8
                              "e2e5204f0258896446f8f943eccb94688eda05ca")
           ,@(digest-bit-test 55 #x08 8
                              "bce31d00762d3d3699caf25bac4bbe27c4853530")
           ,@(digest-bit-test 55 #x04 8
                              "296b3124d4aa6c9e37a08720d6a7697cc075340f")
           ,@(digest-bit-test 55 #x02 8
                              "d14eb2bb8ec810a4cbff2189095f99ec54ca0bab")
           ,@(digest-bit-test 55 #x01 8
                              "a02059c3ac82077c2081c90c869257c530ab43c2")
           ,@(digest-bit-test 56 #x80 7
                              "73c80b1d08cbfd229cad79f4f613a1d2a5e442ea")
           ,@(digest-bit-test 56 #x40 7
                              "1da62f48ebb2d50ec062dd98c85fe8345b1129ec")
           ,@(digest-bit-test 56 #x20 7
                              "2fdfa42088be5e2ef6afa13890635adb64bf59a7")
           ,@(digest-bit-test 56 #x10 7
                              "29f98848cc4e358fe51512739fd2985a3d9c5592")
           ,@(digest-bit-test 56 #x08 7
                              "aed5c356ed2daa62bf20174834062b66f728c39c")
           ,@(digest-bit-test 56 #x04 7
                              "26c420f37dd3c7cdffef3edd8e2f1842afefecbd")
           ,@(digest-bit-test 56 #x02 7
                              "cc70839427bc048bb08bb44e67758d1124b643be")
           ,@(digest-bit-test 56 #x01 7
                              "dc393101e9b13892dc97ea811dd6d33421e672ac")
           ,@(digest-bit-test 57 #x80 6
                              "d01e8d33c9eafbd8be5369e3b6a857074be5f78b")
           ,@(digest-bit-test 57 #x40 6
                              "13db83187325b05980e84aaee5c632d028109b17")
           ,@(digest-bit-test 57 #x20 6
                              "3d6e9c628537656eb88dc5f76e18e2a2dceb38a7")
           ,@(digest-bit-test 57 #x10 6
                              "deb2662ac60da809bb5d94e2a5b9b38a7696d383")
           ,@(digest-bit-test 57 #x08 6
                              "bd9e94d831bf1235dccc7d361aa374c97501e87b")
           ,@(digest-bit-test 57 #x04 6
                              "6d9052727fc9912cbbcb67120d2fd27c3c6e9a28")
           ,@(digest-bit-test 57 #x02 6
                              "e8640e2a840de60356471f4b44220a9e15266a73")
           ,@(digest-bit-test 57 #x01 6
                              "c09a06651d0e3599ed42fac3726575efc3404c66")
           ,@(digest-bit-test 58 #x80 5
                              "f42c449ec2d162e5a7cb1688133bf9a290a9c3b3")
           ,@(digest-bit-test 58 #x40 5
                              "d399a7b5077bcb4527194109e04ef89cc71277ea")
           ,@(digest-bit-test 58 #x20 5
                              "866bb6b24e81487390f6a36545379421ade02b6f")
           ,@(digest-bit-test 58 #x10 5
                              "7cbb546d49007e94d064d4f905245d19b9060eab")
           ,@(digest-bit-test 58 #x08 5
                              "4d58003b6f36a7352f3ecf258fa4509d79e7d2ce")
           ,@(digest-bit-test 58 #x04 5
                              "c80ba62be5da26073c287aa03beedb4e916bb0fe")
           ,@(digest-bit-test 58 #x02 5
                              "06ab61cb329f3423ae513b49551191d6fa515fb1")
           ,@(digest-bit-test 58 #x01 5
                              "2ff9af0faf9a3b0ab42de6b02e77fdc5b297ce28")
           ,@(digest-bit-test 59 #x80 4
                              "b2a39aaa8924f3d8059734794597889477f27e6f")
           ,@(digest-bit-test 59 #x40 4
                              "8d06bc2c793d856974ae5459aa669169e07eac62")
           ,@(digest-bit-test 59 #x20 4
                              "0833abd972dd3228da4f024f5662dbe2117282d7")
           ,@(digest-bit-test 59 #x10 4
                              "a4ece25fbfd97e44832f6b89a0648e248e2fd49f")
           ,@(digest-bit-test 59 #x08 4
                              "616310fdb4e72b3b985281c3ebd1c176a1273cfd")
           ,@(digest-bit-test 59 #x04 4
                              "9d19f19b80897024806f8cb2325960e375727ed7")
           ,@(digest-bit-test 59 #x02 4
                              "9e14014ee80e7614091f2aa5a0a9caf27909f313")
           ,@(digest-bit-test 59 #x01 4
                              "5d119d7f6858cd7495de1e9a645d2f80f8291df5")
           ,@(digest-bit-test 60 #x80 3
                              "ebb2f360ab47f053a8bc736f45f33158c6ea878c")
           ,@(digest-bit-test 60 #x40 3
                              "5fe1a052aa885d1b4ad99d9f196dbe92cf65885d")
           ,@(digest-bit-test 60 #x20 3
                              "f552bee8d59bf0654ac344f1a0cc3ae5597a7a71")
           ,@(digest-bit-test 60 #x10 3
                              "dc7825ac0cd824f74ab7a47b899300c3096d8667")
           ,@(digest-bit-test 60 #x08 3
                              "fa5d5599c5660ed0665a79ec395c722997bc5ac2")
           ,@(digest-bit-test 60 #x04 3
                              "ef8916d8a9efcf4d6e02fe72de8cab90a3992262")
           ,@(digest-bit-test 60 #x02 3
                              "9f4ed685d398a752bc4ee8c0891d724258121d25")
           ,@(digest-bit-test 60 #x01 3
                              "5d36b7997b600229d9421d81a9ea1cb1da1bed2d")
           ,@(digest-bit-test 61 #x80 2
                              "b1da174937c24516a28c7f4770b98f8df059ed1b")
           ,@(digest-bit-test 61 #x40 2
                              "890e8d2c34e060193ab21de16b1c1929616d6eda")
           ,@(digest-bit-test 61 #x20 2
                              "ab44a81ddb33c2439e2df6eb42b3da5adb4460a6")
           ,@(digest-bit-test 61 #x10 2
                              "4796defe552974795285841588c9d0b0c2b39e21")
           ,@(digest-bit-test 61 #x08 2
                              "c42cce86691b2b0a0a7297d3fc3077de7b875457")
           ,@(digest-bit-test 61 #x04 2
                              "8969bbaf55ec689588998adac8a0ceebdba06dc3")
           ,@(digest-bit-test 61 #x02 2
                              "05f6a29ae91b66cdbc0d7f3d349df5aa6519366d")
           ,@(digest-bit-test 61 #x01 2
                              "554e489049a20d8bd47fb1234ea397e21d8cae77")
           ,@(digest-bit-test 62 #x80 1
                              "293cadc30c0cd9cf55ed269d42fb1758e5c71667")
           ,@(digest-bit-test 62 #x40 1
                              "aa0d67f4e35b04373c2a73a139a8fe8a9f1d0680")
           ,@(digest-bit-test 62 #x20 1
                              "9f10e6dff017bc8553cc93c9255e3a1441c55df5")
           ,@(digest-bit-test 62 #x10 1
                              "3a459f9ee9ca8ecbcf864769a0d30b2a9a0aa9fb")
           ,@(digest-bit-test 62 #x08 1
                              "c5a5f5833988bb1b920b7c7a7324890b7e681761")
           ,@(digest-bit-test 62 #x04 1
                              "dd81b919473c77d804df031ee569571657195f9c")
           ,@(digest-bit-test 62 #x02 1
                              "e156b150616e25c4cc689a5a10849b2cb9c4c8c7")
           ,@(digest-bit-test 62 #x01 1
                              "83698fcbba5cbe3b4e67b35466425b28c4e5162b")
           ,@(digest-bit-test 63 #x80 0
                              "ecafa6f24326f8cec555731834168ec7a75aa577")
           ,@(digest-bit-test 63 #x40 0
                              "cbc2cf467401231717ce7339bcd8591665823f46")
           ,@(digest-bit-test 63 #x20 0
                              "06daa528dfd015e666c579f6aa997e50ecef2451")
           ,@(digest-bit-test 63 #x10 0
                              "d84b71fdfd8e9f0a76aa1eb174cd253789d6408b")
           ,@(digest-bit-test 63 #x08 0
                              "74d9106cc9c67f307425cf940cc588b278f84ae2")
           ,@(digest-bit-test 63 #x04 0
                              "68b9eb81c30694d4a3ee926c53a08f8b76b099e5")
           ,@(digest-bit-test 63 #x02 0
                              "d229d9d61e24b80cb32373bb3362a3bdc7dcce73")
           ,@(digest-bit-test 63 #x01 0
                              "aae81062811edfd2af3081941d667fb7033dce80")

           (,(multiple-sha1 1 "abc") "a9993e364706816aba3e25717850c26c9cd0d89d")
           (,(multiple-sha1 1 "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq") "84983e441c3bd26ebaae4aa1f95129e5e54670f1")
           ;; (,(multiple-sha1 100000 "aaaaaaaa") "34aa973cd4c4daa4f61eeb2bdbad27316534016f")

           (,(multiple-sha1 10 "0123456701234567012345670123456701234567012345670123456701234567") "dea356a2cddd90c7a7ecedc5ebb563934f460452")
          )))
    (let loop ((tests tests))
      (cond ((null? tests) #t)
            (else
             ;; (display "-----------\n")
             (let* ((test (car tests))
                    (text (car test))
                    (expected-digest (cadr test))
                    (actual-digest (bytes->hex-string (sha-1 text))))
               (cond ((equal? expected-digest actual-digest)
                      (loop (cdr tests)))
                     (else
                      (display "text: ") (write text) (newline)
                      (display "expected-digest: ")
                      (write expected-digest)
                      (newline)
                      (display "  actual-digest: ")
                      (write actual-digest)
                      (newline))))))))



  ;; (display "large file...\n")
  ;; (let ((p (open-binary-input-file "/home/seth/tmp/users.tar.gz")))
  ;;   (write (md5 p))
  ;;   (close-input-port p)
  ;;   (newline))

  #t)


(define (test-hmac-sha-1)
  (let ((tests
         ;; from chicken egg tests
         `(("64608bd9aa157cdfbca795bf9a727fc191a50b66" "hi" "food is good")
           ("511387216297726a7947c6006f5be89711662b1f"
            "hi my name is the big bad wolf" "hi")
           ("73dc948bab4e0c65b1e5d18ae3694a39a4788bee"
            "key" "this is a really long message that is going to being run through this hmac test to make sure that it works correctly.")
           ;; wikipedia
           ("de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9"
            "key" "The quick brown fox jumps over the lazy dog"))))

    (let loop ((tests tests))
      (cond ((null? tests) #t)
            (else
             (let* ((test (car tests))
                    (expected (list-ref test 0))
                    (key (list-ref test 1))
                    (message (list-ref test 2))
                    (calced (bytes->hex-string (hmac-sha-1 key message))))
               (if (equal? expected calced)
                   (loop (cdr tests))
                   (begin
                     (display "key: ") (write key) (newline)
                     (display "message: ") (write message) (newline)
                     (display "expected: ") (write expected) (newline)
                     (display "  calced: ") (write calced) (newline)
                     #f)))))))
  )


(define (test-sha-224)
  (let ((tests
         ;; tests from chibi
         '((""
            "d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f")
           ("abc"
            "23097d223405d8228642a477bda255b32aadbce4bda0b3f7e36c9da7")
           ("The quick brown fox jumps over the lazy dog"
            "730e109bd7a8a32b1cb9d9a09aa2325d2430587ddbc0c38bad911525")
           ;; wikipedia
           ("The quick brown fox jumps over the lazy dog."
            "619cba8e8e05826e9b8c519c0a5c68f4fb653e8a3d8aa04bb2c8cd4c")
           )))

    (let loop ((tests tests))
      (cond ((null? tests) #t)
            (else
             (let* ((tst (car tests))
                    (str (car tst))
                    (expected-hash (cadr tst))
                    (computed-hash (bytes->hex-string (sha-224 str))))
               (cond ((equal? expected-hash computed-hash)
                      (display "sha-224 of ")
                      (write str)
                      (display " --> ok\n")
                      (loop (cdr tests)))
                     (else
                      (display "sha-224 failed:\n")
                      (display "     str: ") (write str) (newline)
                      (display "expected: ") (write expected-hash) (newline)
                      (display "computed: ") (write computed-hash) (newline)
                      #f))))))))


(define (test-sha-256)
  (let ((tests
         ;; tests from chibi
         '((""
            "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
           ("abc"
            "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad")
           ("The quick brown fox jumps over the lazy dog"
            "d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592")
           ;; test from chicken
           ("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"
            "248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1")

           )))
    (let loop ((tests tests))
      (cond ((null? tests) #t)
            (else
             (let* ((tst (car tests))
                    (str (car tst))
                    (expected-hash (cadr tst))
                    (computed-hash (bytes->hex-string (sha-256 str))))
               (cond ((equal? expected-hash computed-hash)
                      (display "sha-256 of ")
                      (write str)
                      (display " --> ok\n")
                      (loop (cdr tests)))
                     (else
                      (display "sha-256 failed:\n")
                      (display "     str: ") (write str) (newline)
                      (display "expected: ") (write expected-hash) (newline)
                      (display "computed: ") (write computed-hash) (newline)
                      #f))))))))


(define (main-program)
  (and (test-md5)
       (test-sha-1)
       (test-hmac-sha-1)
;       (test-sha-224)
       (test-sha-256)
       ))
