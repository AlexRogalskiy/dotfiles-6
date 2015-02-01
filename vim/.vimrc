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

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

nmap \e :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

execute pathogen#infect()
