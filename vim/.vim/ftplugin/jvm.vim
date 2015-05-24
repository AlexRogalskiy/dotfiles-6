" javacomplete
setlocal omnifunc=javacomplete#Complete
map <leader>b :call javacomplete#GoToDefinition()<CR>

" autocomplete
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

let g:nailgun_port = 2113
let g:javacomplete_ng = "/usr/local/bin/ng"

let g:scala_sort_across_groups=1

" set sourcepath to cwd
call javacomplete#AddSourcePath(getcwd())

" preemptively start the server
call javacomplete#StartServer()

" sort imports on save
autocmd BufWritePre <buffer> ":SortScalaImports :retab"
