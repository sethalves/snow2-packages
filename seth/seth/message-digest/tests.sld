(define-library (seth message-digest tests)
  (export run-tests)
  (import (scheme base)
          (scheme file)
          (scheme write)
          (snow bytevector)
          (seth message-digest primitive)
          (seth message-digest type)
          (seth message-digest bv)
          (seth message-digest port)
          (seth message-digest md5)
          (seth message-digest update-item)
          (seth message-digest item))
  (begin
    (define (run-tests)

      (let ((mdp (make-message-digest-primitive
                  (lambda ()
                    ;; (set-finalizer! (allocate ctx-info) free)
                    (display "context gotten\n")
                    (make-bytevector 5 0))
                  15
                  (lambda (ctx)
                    (display "init called: ")
                    (write ctx) (newline)
                    #t)
                  (lambda (ctx data len)
                    (display "update called: ")
                    (write ctx)
                    (display " data: ")
                    (write data)
                    (display " len: ")
                    (write len)
                    (newline)
                    #t)
                  (lambda (ctx data)
                    (display "final called:")
                    (write ctx)
                    (display " data: ")
                    (write data)
                    (newline)
                    #t))))
        ;; (initialize-message-digest mdp)
        (message-digest-string mdp "abc")

        (newline)
        (newline)

        (let ((p (open-output-digest mdp)))
          (display "fuh\n" p)
          (get-output-digest p))

        #t)

      (newline)
      (newline)

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
                        (actual-digest (message-digest-string
                                        (md5-primitive) text)))
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
      ;; (let ((p (open-input-file "/home/seth/tmp/users.tar.gz")))
      ;;   (write (message-digest-port (md5-primitive) p))
      ;;   (close-input-port p)
      ;;   (newline))

      )))
