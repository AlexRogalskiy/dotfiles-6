set tabstop=2
set shiftwidth=2
set expandtab
set autoindent

set number

set backspace=indent,eol,start
set mouse=a

set incsearch
set ignorecase
set smartcase
set hlsearch

filetype indent on
filetype on
filetype plugin on
syntax on

nmap \e :NERDTreeToggle<CR>

execute pathogen#infect()
