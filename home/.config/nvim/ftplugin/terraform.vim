autocmd BufWritePre *.tf call terraform#fmt()

let g:neomake_open_list = 2
call neomake#configure#automake('w')
