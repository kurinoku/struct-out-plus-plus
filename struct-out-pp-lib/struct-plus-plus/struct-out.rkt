#lang racket/base

(require struct-plus-plus
         (for-syntax racket/provide-transform
                     racket/struct-info
                     racket/base
                     racket/syntax
                     syntax/parse
                     syntax/stx))

(provide struct-out++
         provide-struct++)

(define-for-syntax ((make-f fmt) s)
  (for*/list ([field (in-list (struct-field-info-list (syntax-local-value s)))]
              [f (in-value (format-id #:source s s fmt s field))]
              #:when (identifier-binding f))
    f))

(define-for-syntax get-dotted-accessors (make-f "~a.~a"))
(define-for-syntax get-updaters (make-f "update-~a-~a"))
(define-for-syntax get-setters (make-f "set-~a-~a"))
     

(define-syntax struct-out++
  (make-provide-transformer
   (lambda (stx modes)
     (syntax-parse stx
       [(_ s:id)
        #:with (dotted ...) (get-dotted-accessors #'s)
        #:with (setters ...) (get-setters #'s)
        #:with (updaters ...) (get-updaters #'s)
        #:with s++ (format-id #:source #'s #'s "~a++" #'s)
        (expand-export
         #'(combine-out (struct-out s)
                        s++
                        dotted ...
                        setters ...
                        updaters ...)
         modes)]))))

(define-syntax (provide-struct++ stx)
  (syntax-parse stx
    [(_ s:id)
     #:with (dotted ...) (get-dotted-accessors #'s)
     #'(provide (struct-out s)
                dotted ...)]))
                        
