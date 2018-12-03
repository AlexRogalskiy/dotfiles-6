" imports, automatically
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>gd <Plug>(go-doc)

let g:neomake_go_go_maker = {
        \ 'args': [
            \ 'build'
            \ ],
        \ 'errorformat':
            \ '%W%f:%l: warning: %m,' .
            \ '%E%f:%l:%c:%m,' .
            \ '%E%f:%l:%m,' .
            \ '%C%\s%\+%m,' .
            \ '%-G#%.%#'
        \ }
let g:neomake_go_enabled_makers = [ 'go', 'golint' ]

au! BufReadPost *.go DeopleteEnable

au! BufWritePost *.go GoBuild
au! BufWritePost *_test.go GoTestCompile

let g:enable_ycm_at_startup = 0
let g:deoplete#enable_at_startup = 1

set tabstop=4 shiftwidth=4 colorcolumn=80

let g:neomake_open_list = 2
call neomake#configure#automake('w')
