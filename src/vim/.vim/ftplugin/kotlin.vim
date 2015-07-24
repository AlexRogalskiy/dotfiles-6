TagbarOpen
IndentGuidesEnable

runtime! ftplugin/jvm.vim

setlocal expandtab
let g:rooter_patterns = ['pom.xml', 'build.sbt', 'project/', 'project.clj']

" dont autoload the entire maven classpath
let g:syntastic_java_javac_autoload_maven_classpath = 0
