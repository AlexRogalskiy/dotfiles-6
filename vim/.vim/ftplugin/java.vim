TagbarOpen

setlocal expandtab

setlocal omnifunc=javacomplete#Complete
map <leader>b :call javacomplete#GoToDefinition()<CR>

" set sourcepath to cwd
call javacomplete#AddSourcePath(getcwd())

" dont autoload the entire maven classpath
let g:syntastic_java_javac_autoload_maven_classpath = 0

" autocomplete
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

let g:nailgun_port = 2113
let g:javacomplete_ng = "/usr/local/bin/ng"

let g:scala_sort_across_groups=1

" sort imports on save
autocmd BufWritePre <buffer> ":SortScalaImports :retab"
