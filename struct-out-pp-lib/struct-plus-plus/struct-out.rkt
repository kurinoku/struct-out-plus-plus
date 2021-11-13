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

(define-for-syntax (get-dotted-accessors s)
  (for*/list ([field (in-list (struct-field-info-list (syntax-local-value s)))]
              [dotted-acc (in-value (format-id #:source s s "~a.~a" s field))]
              #:when (identifier-binding dotted-acc))
    dotted-acc))
     

(define-syntax struct-out++
  (make-provide-transformer
   (lambda (stx modes)
     (syntax-parse stx
       [(_ s:id)
        #:with (dotted ...) (get-dotted-accessors #'s)
        #:with s++ (format-id #:source #'s #'s "~a++" #'s)
        (expand-export
         #'(combine-out (struct-out s)
                        s++
                        dotted ...)
         modes)]))))

(define-syntax (provide-struct++ stx)
  (syntax-parse stx
    [(_ s:id)
     #:with (dotted ...) (get-dotted-accessors #'s)
     #'(provide (struct-out s)
                dotted ...)]))
                        
