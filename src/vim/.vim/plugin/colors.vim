command Light colorscheme base16-default |
			\set background=light |
			\let g:lightline.colorscheme = '16color' |
			\call lightline#init() |
			\call lightline#colorscheme() |
			\call lightline#update() |
			\call buftabline#update("")

command Dark colorscheme base16-default |
			\set background=dark |
			\let g:lightline.colorscheme = '16color' |
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
