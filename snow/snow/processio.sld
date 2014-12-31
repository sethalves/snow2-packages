(define-library (snow processio)
  (export snow-open-subprocess
          subprocess-stdin-port
          subprocess-stdout-port
          subprocess-stderr-port
          subprocess-pid
          snow-subprocess-wait
          snow-subprocess-run

          ;; backwards compatibility
          snow-open-shell-command-process
          shell-command-process-input-port
          shell-command-process-output-port
          )
  (import (scheme base)
          (scheme write) ;; XXX delete
          (snow filesys)
          (snow extio)
          )
  (cond-expand
   (chibi (import (chibi io) (chibi process) (chibi filesystem)))
   (chicken (import (chicken) (posix)))
   (gauche (import (gauche process)))
   (sagittarius
    (import (only (rnrs)
                  transcoded-port
                  make-transcoder
                  utf-8-codec
                  eol-style)
            (only (sagittarius)
                  current-directory
                  set-current-directory))
    (import (sagittarius process)))
   (foment)
   )
  (begin

;;;============================================================================

;;; File: "processio.scm", Time-stamp: <2007-05-03 20:45:34 feeley>

;;; Copyright (c) 2007 by Nils M Holm, All Rights Reserved.
;;; Copyright (c) 2007 by Marc Feeley, All Rights Reserved.

;;;============================================================================

;;; Provides I/O to operating system subprocesses.


;;;============================================================================

(define-record-type <subprocess>
  (make-subprocess stdin-port stdout-port stderr-port pid native)
  subprocess?
  (stdin-port subprocess-stdin-port)
  (stdout-port subprocess-stdout-port)
  (stderr-port subprocess-stderr-port)
  (pid subprocess-pid)
  (native subprocess-native)
  )


(cond-expand

 (chibi
  ;; http://synthcode.com/scheme/chibi/lib/chibi/process.html
  (define (snow-open-subprocess command-and-args . cwd-oa)
    (let* ((parent-cwd (current-directory))
           (cwd (if (null? cwd-oa) parent-cwd (car cwd-oa)))
           (result #f))
      (change-directory cwd)
      (call-with-process-io
       command-and-args
       (lambda (pid proc-stdin proc-stdout proc-stderr)
         (set! result
               (make-subprocess proc-stdin proc-stdout proc-stderr pid #f))))
      (change-directory parent-cwd)
      result))

  (define (snow-subprocess-wait p)
    (waitpid (subprocess-pid p) 0)))

 (chicken

  (define (snow-open-subprocess command-and-args . cwd-oa)
    (let* ((parent-cwd (current-directory))
           (cwd (if (null? cwd-oa) parent-cwd (car cwd-oa))))
      (change-directory cwd)
      (let-values (((proc-stdout proc-stdin pid proc-stderr)
                    (process* (car command-and-args)
                              (cdr command-and-args))))
        (change-directory parent-cwd)
        (make-subprocess proc-stdin proc-stdout proc-stderr
                         pid #f))))

  (define (snow-subprocess-wait p)
    (if (output-port-open? (subprocess-stdin-port p))
        (close-output-port (subprocess-stdin-port p)))
    (if (input-port-open? (subprocess-stdout-port p))
        (close-input-port (subprocess-stdout-port p)))
    (if (input-port-open? (subprocess-stderr-port p))
        (close-input-port (subprocess-stderr-port p))))
  )

 ;; (gambit

 ;;  (define (snow-open-subprocess command)
 ;;    (let ((port
 ;;           (open-process
 ;;            (list path: "/bin/sh"
 ;;                  arguments: (list "-c" (string-append "exec " command))
 ;;                  stderr-redirection: #t))))
 ;;      (make-subprocess port port))))

 (gauche
  (define (snow-open-subprocess command-and-args . cwd-oa)
    (let* ((parent-cwd (current-directory))
           (cwd (if (null? cwd-oa) parent-cwd (car cwd-oa))))
      (change-directory cwd)
      (let ((proc (apply run-process
                         (append
                          command-and-args
                          (list
                           :input :pipe
                           :output :pipe
                           :error :pipe)))))
        (change-directory parent-cwd)
        (make-subprocess
         (process-input proc)
         (process-output proc)
         (process-error proc)
         (process-pid proc)
         proc))))

  (define (snow-subprocess-wait p)
    (process-wait (subprocess-native p)))
  )


 (sagittarius
  ;; http://ktakashi.github.io/sagittarius-ref.html#G1333
  (define (snow-open-subprocess command-and-args . cwd-oa)
    (define (bin->textual port)
      (transcoded-port port (make-transcoder (utf-8-codec) (eol-style none))))
    (let* ((parent-cwd (current-directory))
           (cwd (if (null? cwd-oa) parent-cwd (car cwd-oa)))
           (p (make-process (car command-and-args) (cdr command-and-args))))
      (set-current-directory cwd)
      (let ((pid (process-call p)))
        (set-current-directory parent-cwd)
        (make-subprocess (bin->textual (process-input-port p))
                         (bin->textual (process-output-port p))
                         (bin->textual (process-error-port p))
                         pid p))))

  (define (snow-subprocess-wait p)
    (process-wait (subprocess-native p)))
  )


 (foment
  (define (snow-open-subprocess command-and-args . cwd-oa)
    (error "snow-open-subprocess is unimplemented"))

  (define (snow-subprocess-wait p)
    (error "snow-subprocess-wait is unimplemented"))))

(define (snow-open-shell-command-process . command-and-args)
  (snow-open-subprocess command-and-args))
(define shell-command-process-input-port subprocess-stdout-port)
(define shell-command-process-output-port subprocess-stdin-port)


(define (snow-subprocess-run command-and-args . cwd-oa)
  ;; run a subprocess with no input.  capture output and error output.
  ;; raise a condition if there is any error output, else return
  ;; standard output as a string.
  (let* ((p (if (null? cwd-oa)
                (snow-open-subprocess command-and-args)
                (snow-open-subprocess command-and-args (car cwd-oa))))
         (ci-in (subprocess-stdin-port p))
         (ci-out (subprocess-stdout-port p))
         (ci-err (subprocess-stderr-port p)))
    (close-output-port ci-in)
    (let ((output (snow-read-string #f ci-out))
          (errput (snow-read-string #f ci-err)))
      (close-input-port ci-out)
      (close-input-port ci-err)
      (snow-subprocess-wait p)
      (cond ((and (string? errput)
                  (> (string-length errput) 0))
             (error "stderr-output" (list errput output)))
            (else
             output)))))



;;;============================================================================
))
