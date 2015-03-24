set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" defaults
Plugin 'tpope/vim-sensible'

" helper windows
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'

" tab markers
Plugin 'Yggdroot/indentLine'

" tab for autocomplete
Plugin 'ervandew/supertab'
" automatic closing of pairs ([{
Plugin 'Raimondi/delimitMate'

" languages
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ivalkeen/vim-simpledb'
Plugin 'derekwyatt/vim-scala'
Plugin 'fatih/vim-go'

call vundle#end()

set rtp+=~/.vim/javacomplete

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

" tabline
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '│'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'

" straight lines because inconsolata doesn't like arrows
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline_left_sep = ''
let g:airline_right_sep = ''

" navigation plugins
" f for files
" n for navigation
nmap <leader>f :NERDTreeToggle<CR>
nmap <leader>n :TagbarToggle<CR>

" move between buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-b> :bprevious<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
