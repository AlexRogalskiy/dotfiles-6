runtime! ftplugin/jvm.vim

let g:neomake_scala_fsc_maker = {
        \ 'args': [ '-d', '/tmp' ],
        \ 'errorformat':
            \ '%E%f:%l: %trror: %m,' .
            \ '%Z%p^,' .
            \ '%-G%.%#'
        \ }

let g:neomake_scala_enabled_makers= [ 'fsc', 'scalastyle' ]

au! BufWritePost *.scala Neomake

set expandtab tabstop=4 shiftwidth=4 softtabstop=0
