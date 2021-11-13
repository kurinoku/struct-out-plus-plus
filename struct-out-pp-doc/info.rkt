#lang info
(define collection 'multi)
(define deps '("base"))
(define pkg-desc "documentation of \"struct-out-plus-plus\"")
(define pkg-authors '(kurinoku))
(define build-deps '("scribble-lib" "racket-doc" "struct-out-pp-lib"))
(define update-implies '("struct-out-pp-lib"))
(define license '(MIT))
