set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" ORDER HERE IS LOAD ORDER

Plugin 'gmarik/Vundle.vim'

" defaults
Plugin 'tpope/vim-sensible'

" set vim working directory to git root
Plugin 'airblade/vim-rooter'

" syntax
Plugin 'scrooloose/syntastic'

" helper windows
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'

" sql
Plugin 'ivalkeen/vim-simpledb'

" golang
Plugin 'fatih/vim-go'

" java / jvm
Plugin 'robertcboll/javacomplete'
Plugin 'robertcboll/vim-cp'

" scala
Plugin 'derekwyatt/vim-scala'

" convenience plugins
" tab markers
Plugin 'nathanaelkane/vim-indent-guides'
" tab for autocomplete
Plugin 'ervandew/supertab'
" automatic closing of pairs ([{
Plugin 'Raimondi/delimitMate'
" comments toggled with <Leader>c<space>
Plugin 'scrooloose/nerdcommenter'

" colors
Plugin 'duythinht/inori'
Plugin 'NLKNguyen/papercolor-theme'

call vundle#end()

filetype plugin indent on
set tabstop=2 shiftwidth=2
set autoindent

set number

syntax enable
silent! colorscheme inori

set clipboard+=unnamed
set backspace=indent,eol,start
set mouse=a

set incsearch
set ignorecase
set smartcase

" tab guides
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
"hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=black
hi ColorColumn ctermbg=black

" show hidden files in tree
let g:NERDTreeShowHidden=1

" syntastic
" always populate the location list
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" sbt files, maven/ivy downloaded sources, jdk source
let g:syntastic_ignore_files = ['.*\.sbt', 
			\'.*\.m2.*', '.*\.ivy2.*', 
			\'/Library.*']

" ctrlp
" show dotfiles
let g:ctrlp_show_hidden = 1
" filename matching > path matching
let g:ctrlp_by_filename = 1

let g:rooter_silent_chdir = 1

" navigation plugins
nnoremap <leader>f :NERDTreeToggle<CR>
nnoremap <leader>t :TagbarToggle<CR>

" move between buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-b> :bprevious<CR>

" vertical split buffer
nnoremap <leader>w <C-w>v<C-w>l

" nerdtree for directory render
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
