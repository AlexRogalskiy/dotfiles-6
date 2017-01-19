let g:rooter_patterns = [
            \'pom.xml', 'build.sbt', 'build.gradle', 'project/', 'project.clj']

setlocal omnifunc=javacomplete#Complete

function! SetCP()
    if !exists('b:cp')
        call javacomplete#classpath#classpath#BuildClassPath()
        let b:cp=g:JavaComplete_LibsPath.g:JavaComplete_SourcesPath.g:JavaComplete_CompiledPath
    endif
    let $CLASSPATH=b:cp
endfunction

command! SetCP call SetCP()
au! BufReadPost * SetCP
