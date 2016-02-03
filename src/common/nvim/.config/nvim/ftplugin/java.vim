runtime! ftplugin/jvm.vim

" mappings
map <leader>ds :call g:javacomplete#GoToDefinition()<cr>

" javacomplete
setlocal omnifunc=javacomplete#Complete

function! SetCP()
    if !exists('b:cp')
        let b:cp=g:JavaComplete_LibsPath.g:JavaComplete_SourcesPath.g:JavaComplete_CompiledPath
    endif
    let $CLASSPATH=b:cp
endfunction

au! BufReadPost *.java call SetCP()
au! BufWritePost *.java Neomake

set expandtab tabstop=4 shiftwidth=4 softtabstop=0
