"----------------------------------------------------------#
" Global Settings
"----------------------------------------------------------#
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

set nocp incsearch ruler showcmd ts=2 sw=2 et
set listchars=tab:>-,trail:-
set modelines=4
set nu                              " line numbers
set backspace=2                     " more powerful backspace
set ignorecase smartcase            " smart case matching
set scrolloff=3                     " keep some context when scrolling
"let php_folding=1

filetype plugin indent on
syntax on

" rebuild help tags
Helptags

" automatically show diff when running 'git commit'
autocmd BufRead *.git/COMMIT_EDITMSG DiffGitCached | wincmd p

source $VIMRUNTIME/macros/matchit.vim

" Google-specific settings
if filereadable($HOME . "/.vim/google.vim")
  source $HOME/.vim/google.vim
endif

"----------------------------------------------------------#
" Filetype-specific Settings
"----------------------------------------------------------#

" localvimrc settings
let g:localvimrc_ask = 0

"----------------------------------------------------------#
" Key bindings
"----------------------------------------------------------#
"nmap <F9> :!vim-ftp %<CR><CR>
"map! <F9> :!vim-ftp %<CR><CR>

map <F2> :NERDTreeToggle<CR>
