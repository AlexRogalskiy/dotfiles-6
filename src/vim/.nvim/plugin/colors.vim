command Light colorscheme PaperColor | let g:lightline.colorscheme = 'PaperColor' | set background=light | call lightline#init() | call lightline#update()

command Dark colorscheme inori | let g:lightline.colorscheme = 'wombat' | set background=light | call lightline#init() | call lightline#update()

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
