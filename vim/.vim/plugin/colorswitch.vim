" switch between light and dark colors

if !empty($ITERM_PROFILE)
	let iterm = $ITERM_PROFILE
	if iterm ==# "light"
		silent! colorscheme tango-morning
	endif
	if iterm ==# "hybrid"
		silent! colorscheme inori
	endif
endif
