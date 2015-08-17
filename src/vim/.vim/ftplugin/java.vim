runtime! ftplugin/jvm.vim

" javacomplete
setlocal omnifunc=g:javacomplete#Complete
map <leader>b :call g:javacomplete#GoToDefinition()<CR>

let g:nailgun_port = 2113
let g:javacomplete_ng = '/usr/local/bin/ng'

" set sourcepath to cwd
call g:javacomplete#AddSourcePath(getcwd())
" preemptively start the server
call g:javacomplete#StartServer()

" syntastic
let g:syntastic_java_checkers = [ 'javac' ]
" dont autoload the entire maven classpath
let g:syntastic_java_javac_autoload_maven_classpath = 0
function! g:Get_vimcp_for_syntastic()
	if exists(b:vimcp)
		return b:vimcp
	endif
	""
endfunction

let g:syntastic_java_javac_custom_classpath_command =
			\g:Get_vimcp_for_syntastic()
