set ts=8 sw=8 noet
set nolist

let g:go_fmt_command = "goimports"

" Go has no max line-length, but set colorcolumn as a reference
set colorcolumn=81

" 'K' on a keyword brings up Godoc
set keywordprg=":GoDoc"

nmap <LocalLeader>i <Plug>(go-info)

nmap <LocalLeader>gd <Plug>(go-doc)
nmap <LocalLeader>gv <Plug>(go-doc-vertical)

nmap <LocalLeader>r <Plug>(go-run)
nmap <LocalLeader>b <Plug>(go-build)
nmap <LocalLeader>t <Plug>(go-test)
nmap <LocalLeader>c <Plug>(go-coverage)
