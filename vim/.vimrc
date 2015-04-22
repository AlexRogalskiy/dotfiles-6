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
"Plugin 'Yggdroot/indentLine'

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

Plugin 'airblade/vim-rooter'

Plugin 'robertcboll/javacomplete'

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

" show tabs as pipes
set list lcs=tab:\|\

" syntastic
" always populate the location list
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" don't compile java
let g:loaded_syntastic_java_javac_checker = 1

" don't conceal quotes in jsons
let g:vim_json_syntax_conceal = 1

" ctrlp
" show dotfiles
let g:ctrlp_show_hidden = 1
" populate list with git
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
" file name matching, not path
let g:ctrlp_by_filename = 1

" airline
" list of buffers
let g:airline#extensions#tabline#enabled = 1

" straight lines because inconsolata doesn't like arrows
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" navigation plugins
nnoremap <leader>f :NERDTreeToggle<CR>
nnoremap <leader>t :TagbarToggle<CR>

" move between buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-b> :bprevious<CR>

" nerdtree for directory render
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
