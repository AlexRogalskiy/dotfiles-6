TagbarOpen

setlocal omnifunc=javacomplete#Complete
map <leader>b :call javacomplete#GoToDefinition()<CR>

" autocomplete
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

let g:nailgun_port = 2113
let g:javacomplete_ng = "/usr/local/bin/ng"
