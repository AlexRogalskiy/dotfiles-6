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

set expandtab tabstop=4 shiftwidth=4 softtabstop=0
