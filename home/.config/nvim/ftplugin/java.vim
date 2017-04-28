runtime! ftplugin/jvm.vim

" mappings
map <leader>ds :call g:javacomplete#GoToDefinition()<cr>

let g:neomake_java_javac_maker = {
    \ 'args': ['-d', '/tmp'],
    \ 'errorformat': '%f:%l: error: %m',
    \ }

au! BufWritePost *.java Neomake

set expandtab tabstop=4 shiftwidth=4 softtabstop=0
