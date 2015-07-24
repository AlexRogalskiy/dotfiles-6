TagbarOpen
IndentGuidesEnable

" mappings for go tools
nmap <Leader>d <Plug>(go-doc)
nmap <Leader>dv <Plug>(go-doc-vertical)
nmap <Leader>db <Plug>(go-doc-browser)

nmap <leader>r <Plug>(go-run)
nmap <leader>b <Plug>(go-build)
nmap <leader>t <Plug>(go-test)
nmap <leader>c <Plug>(go-coverage)

nmap <Leader>re <Plug>(go-rename)

" jump to def
nmap <Leader>ds <Plug>(go-def-split)
nmap <Leader>dv <Plug>(go-def-vertical)
nmap <Leader>dt <Plug>(go-def-tab)

" imports, automatically
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" use syntastic for syntax checking
let g:syntastic_go_checkers = ["go", "gotype", "gofmt", "govet", "golint" ]

" autocomplete
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
