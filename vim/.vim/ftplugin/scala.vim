TagbarOpen
IndentGuidesEnable

runtime! ftplugin/jvm.vim

setlocal expandtab
let g:rooter_patterns = ["pom.xml", "build.sbt", "project/"]

" use fsc only, not scalac
let g:loaded_syntastic_scala_scalac_checker = 1
