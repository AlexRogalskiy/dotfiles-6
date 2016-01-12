runtime! ftplugin/jvm.vim

" mappings
map <leader>ds :call g:javacomplete#GoToDefinition()<cr>
map <leader>i :call g:javacomplete#ReplaceWithImport()<cr>

" javacomplete
setlocal omnifunc=g:javacomplete#Complete

set expandtab tabstop=4 shiftwidth=4 softtabstop=0
