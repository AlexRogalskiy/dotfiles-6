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

au! BufWritePost *.go Neomake

set tabstop=4 shiftwidth=4 colorcolumn=100
