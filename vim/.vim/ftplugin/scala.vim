TagbarOpen
IndentGuidesEnable

setlocal expandtab

setlocal omnifunc=javacomplete#Complete
map <leader>b :call javacomplete#GoToDefinition()<CR>

" use fsc only, not scalac
let g:loaded_syntastic_scala_scalac_checker = 1

" dont autoload the entire maven classpath
let g:syntastic_java_javac_autoload_maven_classpath = 0 

" autocomplete
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

let g:nailgun_port = 2113
let g:javacomplete_ng = "/usr/local/bin/ng"
