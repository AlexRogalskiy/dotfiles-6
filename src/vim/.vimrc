call g:plug#begin('~/.vim/managed')

" visual
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'nathanaelkane/vim-indent-guides'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'

" search
Plug 'kien/ctrlp.vim' | Plug 'FelikZ/ctrlp-py-matcher'

" behavior
Plug 'airblade/vim-rooter'
Plug 'sjl/gundo.vim'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'editorconfig/editorconfig-vim'
Plug 'janko-m/vim-test'

"Plug 'scrooloose/syntastic'
Plug 'benekastah/neomake'

Plug 'Shougo/neocomplete.vim'
Plug 'ervandew/supertab'

" tools
Plug 'tpope/vim-fugitive'
Plug 'tfnico/vim-gradle'

" lang
Plug 'sheerun/vim-polyglot'
Plug 'chase/vim-ansible-yaml', { 'for': 'ansible' }
Plug 'ivalkeen/vim-simpledb', { 'for': 'sql' }
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'roboll/javacomplete', { 'for': 'java' }
Plug 'roboll/vim-cp', { 'for': 'java' }
Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'vim-scripts/HTML-AutoCloseTag', { 'for': 'html' }
Plug 'elzr/vim-json', { 'for': 'json'}

" colors
Plug 'roboll/Apprentice'
Plug 'jonathanfilip/vim-lucius'

call g:plug#end()

" general settings
filetype plugin indent on
syntax enable

set number
set hidden
set incsearch
set ignorecase
set noshowmode

set mouse=a                       " mousing, always
set list listchars=tab:»\ |       " show tabs vs spaces
set clipboard+=unnamed            " use system clipboard
set backspace=indent,eol,start    " sane backspace
set colorcolumn=80                " highlight 80th col
set laststatus=2 showtabline=2    " always show status and bufs
set updatetime=500                " speed up plugin effects
set directory=~/.nvim/swapfiles// " centralize swap files

augroup *
    autocmd FileType vim,html,css,less,javascript,
        \sql,scala,kotlin,groovy,java,json,xml,sh
            \ set expandtab tabstop=4 shiftwidth=4 softtabstop=0
augroup end

autocmd! BufEnter,BufWritePost * Neomake
let g:neomake_error_sign = { 'text': '=>', 'texthl': 'ErrorMsg' }
let g:neomake_warning_sign = { 'text': '=>', 'texthl': 'SignColumn' }

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" indent guides
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1 " will only work with soft tabs

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" enable plugins
let g:strip_whitespace_on_save = 1

let g:ctrlp_show_hidden = 1
let g:ctrlp_by_filename = 1

let g:neocomplete#enable_at_startup = 1
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

" exit automatically when only buffer is nerdtree
autocmd bufenter * if (winnr('$') == 1 &&
            \ exists('b:NERDTreeType') &&
            \ b:NERDTreeType == 'primary') | q | endif
