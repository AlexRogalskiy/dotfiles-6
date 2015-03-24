TagbarOpen

setlocal omnifunc=javacomplete#Complete
map <leader>b :call javacomplete#GoToDefinition()<CR>

" autocomplete
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

let g:nailgun_port = 2113
let g:javacomplete_ng = "/usr/local/bin/ng"

let g:scala_sort_across_groups=1

" sort imports on save
autocmd BufWritePre <buffer> ":SortScalaImports :retab"
