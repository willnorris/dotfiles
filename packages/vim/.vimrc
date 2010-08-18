"----------------------------------------------------------#
" Global Settings
"----------------------------------------------------------#
set nocp incsearch ruler showcmd ts=2 sw=2 et
set listchars=tab:>-,trail:-
set modelines=4
set nu                              " line numbers
set backspace=2                     " more powerful backspace
set ignorecase smartcase            " smart case matching
"let php_folding=1

filetype plugin indent on
syntax on

source $VIMRUNTIME/macros/matchit.vim

" Google-specific settings
if filereadable($HOME . "/.vim/google.vim")
  source $HOME/.vim/google.vim
endif

"----------------------------------------------------------#
" Filetype-specific Settings
"----------------------------------------------------------#
au FileType mkd  set ai formatoptions=tcroqn2 comments=n:>

" localvimrc settings
let g:localvimrc_ask = 0

"----------------------------------------------------------#
" Key bindings
"----------------------------------------------------------#
"nmap <F9> :!vim-ftp %<CR><CR>
"map! <F9> :!vim-ftp %<CR><CR>

