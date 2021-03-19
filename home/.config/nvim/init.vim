call g:plug#begin('~/.config/nvim/managed/')

" visual
Plug 'scrooloose/nerdtree',             { 'on': 'NERDTreeToggle' }
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'
Plug 'majutsushi/tagbar',               { 'on': 'TagbarToggle' }
Plug 'powerman/vim-plugin-AnsiEsc'

" search
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'

" behavior
Plug 'airblade/vim-rooter'
Plug 'Raimondi/delimitMate'
Plug 'ntpeters/vim-better-whitespace'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" build
Plug 'neomake/neomake'
"Plug 'Valloric/YouCompleteMe',          { 'do': './install.py' }
"Plug 'zchee/deoplete-go',               { 'for': 'go', 'do': 'make'}

" lang
"
Plug 'fatih/vim-go',                    { 'tag': '*', 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'reedes/vim-pencil',               { 'for': 'markdown' }
Plug 'hashivim/vim-terraform',          { 'for': 'terraform' }
Plug 'sheerun/vim-polyglot'

Plug 'lambdalisue/vim-manpager'

" colors
Plug 'romainl/Apprentice',              { 'branch': 'fancylines-and-neovim' }
Plug 'junegunn/seoul256.vim'

call g:plug#end()

" general settings
filetype plugin indent on
syntax enable

set number
set hidden
set incsearch
set ignorecase
set noshowmode
set splitright

set mouse=a                               " mousing, always
set list listchars=tab:»\ |               " show tabs vs spaces
set clipboard+=unnamedplus                " use system clipboard
set backspace=indent,eol,start            " sane backspace
set colorcolumn=100                       " highlight 100th col
set laststatus=2 showtabline=2            " always show status and bufs
set updatetime=500                        " speed up plugin effects
set directory=~/.config/nvim/swapfiles//  " centralize swap files

nmap q :q<CR>"

let g:neomake_error_sign = { 'text': '=>', 'texthl': 'ErrorMsg' }
let g:neomake_warning_sign = { 'text': '=>', 'texthl': 'SignColumn' }

" nerdtree
let NERDTreeShowHidden=1

" enable plugins
let g:strip_whitespace_on_save = 1

" let g:enable_ycm_at_startup = 1
" let g:deoplete#enable_at_startup = 0

" let g:polyglot_disabled = ['go']

let g:ctrlp_show_hidden = 1
let g:ctrlp_by_filename = 1

let loaded_netrwPlugin = 1

au BufNewFile,BufRead Dockerfile* set filetype=dockerfile
