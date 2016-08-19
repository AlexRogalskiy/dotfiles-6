call g:plug#begin('~/.config/nvim/managed/')

" visual
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'
Plug 'majutsushi/tagbar',               { 'on': 'TagbarToggle' }
Plug 'nathanaelkane/vim-indent-guides', { 'on': 'IndentGuidesToggle' }

" search
Plug 'kien/ctrlp.vim' | Plug 'FelikZ/ctrlp-py-matcher'

" behavior
Plug 'airblade/vim-rooter'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'editorconfig/editorconfig-vim'

"Plug 'janko-m/vim-test'
Plug 'benekastah/neomake'
"Plug 'scrooloose/syntastic'
Plug 'Valloric/YouCompleteMe',          { 'do': './install.py' }

" tools
Plug 'tpope/vim-fugitive'
Plug 'tfnico/vim-gradle'

" lang
Plug 'sheerun/vim-polyglot'
Plug 'chase/vim-ansible-yaml',          { 'for': 'ansible' }
Plug 'ivalkeen/vim-simpledb',           { 'for': 'sql' }
Plug 'derekwyatt/vim-scala',            { 'for': 'scala' }
Plug 'roboll/vim-javacomplete2'
Plug 'Shougo/deoplete.nvim'
Plug 'udalov/kotlin-vim',               { 'for': 'kotlin' }
Plug 'fatih/vim-go',                    { 'for': 'go' }
Plug 'zchee/deoplete-go',               { 'for': 'go', 'do': 'make'}
Plug 'pangloss/vim-javascript',         { 'for': 'javascript' }
Plug 'groenewege/vim-less',             { 'for': 'less' }
Plug 'vim-scripts/HTML-AutoCloseTag',   { 'for': 'html' }
Plug 'elzr/vim-json',                   { 'for': 'json'}
Plug 'markcornick/vim-terraform',       { 'for': 'terraform' }
Plug 'uarun/vim-protobuf'

Plug 'tpope/vim-fireplace',             { 'for': 'clojure' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-salve'

Plug 'reedes/vim-pencil'
Plug 'powerman/vim-plugin-AnsiEsc'

Plug 'romainl/Apprentice'
Plug 'jonathanfilip/vim-lucius'
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
set colorcolumn=100                       " highlight 80th col
set laststatus=2 showtabline=2            " always show status and bufs
set updatetime=500                        " speed up plugin effects
set directory=~/.config/nvim/swapfiles//  " centralize swap files

nmap q :q<CR>"

let g:neomake_error_sign = { 'text': '=>', 'texthl': 'ErrorMsg' }
let g:neomake_warning_sign = { 'text': '=>', 'texthl': 'SignColumn' }

" indent guides
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1 " will only work with soft tabs

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" nerdtree
let NERDTreeShowHidden=1

" enable plugins
let g:strip_whitespace_on_save = 1

let g:enable_ycm_at_startup = 1
let g:deoplete#enable_at_startup = 0

let g:ctrlp_show_hidden = 1
let g:ctrlp_by_filename = 1

let loaded_netrwPlugin = 1

au BufNewFile,BufRead Dockerfile* set filetype=dockerfile
