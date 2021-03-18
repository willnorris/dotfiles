set ts=8 sw=8 noet
set nolist

" Go has no max line-length, but set colorcolumn as a reference
set colorcolumn=81

nmap <LocalLeader>i <Plug>(go-info)
nmap <LocalLeader>f :GoImports<CR>

nmap <LocalLeader>r <Plug>(go-run)
nmap <LocalLeader>b <Plug>(go-build)
nmap <LocalLeader>t <Plug>(go-test)
nmap <LocalLeader>c <Plug>(go-coverage)

let g:go_def_mapping_enabled = 0 " disable mapping that interferes with fzf
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
