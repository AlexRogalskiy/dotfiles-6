command Light colorscheme seoul256-light |
            \set background=light |
            \let g:lightline.colorscheme = 'seoul256' |
            \call lightline#init() |
            \call lightline#colorscheme() |
            \call lightline#update() |
            \call buftabline#update("")

command Dark colorscheme apprentice |
            \set background=dark |
            \let g:lightline.colorscheme = 'apprentice' |
            \call lightline#init() |
            \call lightline#colorscheme() |
            \call lightline#update() |
            \call buftabline#update("")

command Med colorscheme seoul256 |
            \set background=dark |
            \let g:lightline.colorscheme = 'seoul256' |
            \call lightline#init() |
            \call lightline#colorscheme() |
            \call lightline#update() |
            \call buftabline#update("")

function SetColors()
    if !empty($ITERM_PROFILE)
        if $ITERM_PROFILE ==# "light"
            Light
        endif
        if $ITERM_PROFILE ==# "dark"
            Dark
        endif
    else
        Med
    endif
endfunction

au VimEnter * call SetColors()
