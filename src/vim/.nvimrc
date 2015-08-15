call plug#begin('~/.nvim/plugged')

" visual
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'

" search
Plug 'kien/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'

" behavior
Plug 'airblade/vim-rooter'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'

Plug 'ntpeters/vim-better-whitespace'
Plug 'jeetsukumaran/vim-buffergator'

Plug 'Shougo/deoplete.nvim'

" tools
Plug 'tpope/vim-fugitive'
Plug 'benekastah/neomake'

" lang/syntax
Plug 'ivalkeen/vim-simpledb'
Plug 'derekwyatt/vim-scala'
Plug 'udalov/kotlin-vim'
Plug 'tfnico/vim-gradle'
Plug 'fatih/vim-go'

" colors
Plug 'duythinht/inori'
Plug 'NLKNguyen/papercolor-theme'

call plug#end()

" general settings
filetype plugin indent on
syntax enable

set number
set ignorecase
set clipboard+=unnamedplus " use system clipboard

set laststatus=2 " always show status bar

command! Notes split ~/notes

" leader mappings
" <leader>b toggle buffergator
nnoremap <leader>fs :NERDTreeToggle<CR>
nnoremap <leader>ts :TagbarToggle<CR>
nnoremap <leader>gs :IndentGuidesToggle<CR>

" enable plugins
let g:strip_whitespace_on_save = 1
let g:deoplete#enable_at_startup = 1

" exit automatically when only buffer is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" indent guides settings
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1 " will only work with soft tabs
hi IndentGuidesEven ctermbg=0
