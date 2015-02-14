set nocompatible 
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'bling/vim-airline'

Plugin 'kien/ctrlp.vim'

Plugin 'scrooloose/syntastic'

Plugin 'scrooloose/nerdtree'

Plugin 'ivalkeen/vim-simpledb'

Plugin 'derekwyatt/vim-scala'

Plugin 'fatih/vim-go'

Plugin 'tpope/vim-sensible'

Plugin 'tpope/vim-surround'

Plugin 'majutsushi/tagbar'

Plugin 'Yggdroot/indentLine'

Plugin 'ervandew/supertab'

Plugin 'initrc/eclim-vundle'

Plugin 'vim-scripts/javaDoc.vim'

Plugin 'Raimondi/delimitMate'

Plugin 'udalov/kotlin-vim'

Plugin 'Shougo/neocomplete.vim'

call vundle#end()
filetype plugin indent on

set tabstop=2
set shiftwidth=2
set expandtab
set autoindent

set number

set clipboard+=unnamed
set backspace=indent,eol,start
set mouse=a

set incsearch
set ignorecase
set smartcase

filetype indent on
filetype on
filetype plugin on
syntax on

" scala import order
let g:scala_sort_across_groups=1

" tabline
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '│'

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" eclim
let g:SuperTabDefaultCompletionType = 'context'

" vim-go
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>re <Plug>(go-rename)

let g:go_fmt_command = "goimports"

" navigation plugins
nmap <leader>e :NERDTreeToggle<CR>
nmap <leader>tag :TagbarToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
