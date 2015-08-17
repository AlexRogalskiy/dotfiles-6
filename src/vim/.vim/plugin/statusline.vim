" configs for status line and interop with plugins

let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \		  [ 'fugitive', 'filename' ],
    \		  ['ctrlpmark'] ],
    \   'right': [ [ 'lineinfo' ],
    \ 		   [ 'percent' ],
    \		   [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'MyFugitive',
    \   'filename': 'MyFilename',
    \   'fileformat': 'MyFileformat',
    \   'filetype': 'MyFiletype',
    \   'fileencoding': 'MyFileencoding',
    \   'mode': 'MyMode',
    \   'ctrlpmark': 'CtrlPMark',
    \ },
    \ 'component_type': {
    \   'neomake': 'error',
    \ },
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2"},
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3"}
    \ }

function! g:MyModified()
  return &filetype =~# 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! g:MyReadonly()
  return &filetype !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! g:MyFilename()
  let l:fname = expand('%:t')
  return l:fname ==# 'ControlP' ? g:lightline.ctrlp_item :
        \ l:fname ==# '__Tagbar__' ? g:lightline.fname :
        \ l:fname =~# '__Gundo\|NERD_tree' ? '' :
        \ &filetype ==# 'vimfiler' ? g:vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? g:unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? g:vimshell#get_status_string() :
        \ ('' !=# g:MyReadonly() ? g:MyReadonly() . ' ' : '') .
        \ ('' !=# l:fname ? l:fname : '[No Name]') .
        \ ('' !=# g:MyModified() ? ' ' . g:MyModified() : '')
endfunction

function! g:MyFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD'
	\ && &filetype !~? 'vimfiler' && exists('*fugitive#head')
      let l:mark = "\ue0a0 "  " edit here for cool mark
      let l:_ = g:fugitive#head()
      return strlen(l:_) ? l:mark.l:_ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! g:MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! g:MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! g:MyFileencoding()
  return winwidth(0) > 70 ?
	\ (strlen(&fileencoding) ? &fileencoding : &encoding) : ''
endfunction

function! g:MyMode()
  let l:fname = expand('%:t')
  return l:fname ==# '__Tagbar__' ? 'Tagbar' :
        \ l:fname ==# 'ControlP' ? 'CtrlP' :
        \ l:fname ==# '__Gundo__' ? 'Gundo' :
        \ l:fname ==# '__Gundo_Preview__' ? 'Gundo Preview' :
        \ l:fname =~# 'NERD_tree' ? 'NERDTree' :
        \ &filetype ==# 'unite' ? 'Unite' :
        \ &filetype ==# 'vimfiler' ? 'VimFiler' :
        \ &filetype ==# 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? g:lightline#mode() : ''
endfunction

function! g:CtrlPMark()
  if expand('%:t') =~# 'ControlP'
    call g:lightline#link('iR'[g:lightline.ctrlp_regex])
    return g:lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! g:CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return g:lightline#statusline(0)
endfunction

function! g:CtrlPStatusFunc_2(str)
  return g:lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! g:TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return g:lightline#statusline(0)
endfunction
