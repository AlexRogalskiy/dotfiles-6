runtime! ftplugin/jvm.vim

let g:syntastic_scala_checkers = [ 'fsc', 'scalastyle' ]

" use fsc only, not scalac
let g:loaded_syntastic_scala_scalac_checker = 1
