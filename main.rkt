#lang racket/base
;; ---------------------------------------------------------------------------------------------------

(require "respond.rkt"
         web-server/servlet-env
         web-server/dispatch)

;; ---------------------------------------------------------------------------------------------------

(define (not-found req)
  (respond #:code 404))

(define (dns-update req domain ipaddr)
  (printf "dns-update ~a ~a~n" domain ipaddr)
  (respond/text #:body "ok"))

(define-values (dispatcher url-generator)
  (dispatch-rules
   [("dns" (string-arg) (string-arg)) dns-update ]
   [("dns") #:method (regexp ".*") not-allowed]))

; Start
(serve/servlet dispatcher
               #:servlet-regexp #rx""
               #:command-line? #false
               #:launch-browser? #false
               #:listen-ip #false
               #:file-not-found-responder not-found
               #:port 9001)
