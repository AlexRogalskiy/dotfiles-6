runtime! ftplugin/jvm.vim

" mappings
map <leader>b :call g:javacomplete#GoToDefinition()<cr>
map <leader>i :call g:javacomplete#ReplaceWithImport()<cr>


" javacomplete
setlocal omnifunc=g:javacomplete#Complete

let g:nailgun_port = 2113
let g:javacomplete_ng = '/usr/local/bin/ng'

" set sourcepath to cwd
call g:javacomplete#AddSourcePath(getcwd())
" preemptively start the server
call g:javacomplete#StartServer()

" syntastic
let g:syntastic_java_checkers = [ 'javac' ]
" dont autoload the entire maven classpath
"let g:syntastic_java_javac_autoload_maven_classpath = 0
