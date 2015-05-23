TagbarOpen
IndentGuidesEnable

setlocal expandtab
let g:rooter_patterns = ["pom.xml", "build.sbt", "project/"]

setlocal omnifunc=javacomplete#Complete
map <leader>b :call javacomplete#GoToDefinition()<CR>

" use fsc only, not scalac
let g:loaded_syntastic_scala_scalac_checker = 1

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
