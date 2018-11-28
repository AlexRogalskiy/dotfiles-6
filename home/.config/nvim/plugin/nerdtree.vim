" exit automatically when only buffer is nerdtree
autocmd bufenter * if (winnr("$") == 1
            \&& exists("b:NERDTree")
            \&& b:NERDTree.isTabTree()) | q | endif

" open nerdtree when vim is opened with no file
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && !exists("g:man") | NERDTree | endif
