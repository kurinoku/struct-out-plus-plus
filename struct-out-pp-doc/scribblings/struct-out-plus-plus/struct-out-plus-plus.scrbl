#lang scribble/manual
@require[@for-label[struct-plus-plus/struct-out
                    racket/base]]

@title{struct-out-plus-plus}
@author{kurinoku}

@defmodule[struct-plus-plus/struct-out]

@defform[(struct-out++ id)]{
  Like @racket[struct-out], but also exports @racket[id]++ and tries to export dotted accessors.
       }

