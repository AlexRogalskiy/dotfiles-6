command Light colorscheme cake16 |
			\set background=light |
			\let g:lightline.colorscheme = 'default' |
			\call lightline#init() |
			\call lightline#colorscheme() |
			\call lightline#update() |
			\call buftabline#update("")

command Dark colorscheme Apprentice |
			\set background=dark |
			\let g:lightline.colorscheme = 'apprentice' |
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
	endif
endfunction

au VimEnter * call SetColors()
