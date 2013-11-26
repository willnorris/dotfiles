set ts=8 sw=8 noet

autocmd BufWritePre <buffer> Fmt
"autocmd BufWritePost <buffer> execute 'Lint' | cwindow

" Go has no max line-length, but set colorcolumn as a reference
set colorcolumn=81

nmap <silent> <leader>god :Godoc<CR>
nmap <silent> <leader>gof :Fmt<CR>
