" correct the colorscheme to avoid ^ in status line

function! s:highlight(group, fg, bg, attr)
	let fg = g:inori_colors[a:fg]
	let bg = g:inori_colors[a:bg]
	exec "hi " . a:group . " guifg=" . fg[1]
  exec "hi " . a:group . " ctermfg=" . fg[0]
  exec "hi " . a:group . " guibg=" . bg[1]
  exec "hi " . a:group . " ctermbg=" . bg[0]
  exec "hi " . a:group . " gui=" . a:attr
  exec "hi " . a:group . " cterm=" . a:attr
endfunction

if g:colors_name ==# "inori"
	call s:highlight("StatusLineNC", "WHITE", "BLACK", "NONE")
endif
