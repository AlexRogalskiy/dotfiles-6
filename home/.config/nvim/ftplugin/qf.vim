autocmd BufWinEnter quickfix nnoremap <silent> <buffer>
    \   q :cclose<cr>:lclose<cr>
autocmd BufEnter * if (winnr('$') == 1 && &buftype ==# 'quickfix' ) |
    \   bd|
    \   q | endif
