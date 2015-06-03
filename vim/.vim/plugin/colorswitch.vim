" switch between light and dark colors

function! s:toggle_colors()
	colorscheme tango-morning
endfunction

command! -bang -narg=0 ToggleColors call s:toggle_colors()
