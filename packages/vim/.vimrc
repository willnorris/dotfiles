"#---------------------------------------------------------#
"# ~/.vimrc 
"#
"# @author     William Norris <will@wirewater.org>
"# @modified   2003-08-02 17:49
"#---------------------------------------------------------#


"----------------------------------------------------------#
" Global Settings
"----------------------------------------------------------#
set nocp incsearch ru ts=4 sw=4
set listchars=tab:>-,trail:-
set modelines=4 
set nu                              " line numbers
set backspace=2                     " more powerful backspace
set ignorecase smartcase			" smart case matching
"let php_folding=1

filetype plugin indent on 
syntax on

source $VIMRUNTIME/macros/matchit.vim

"----------------------------------------------------------#
" Filetype-specific Settings
"----------------------------------------------------------#
"autoset options for PHP files
au BufNewFile,BufReadPre,FileReadPre  *.{phps,phtml}  set ft=php
"au BufNewFile,BufReadPre,FileReadPre  *.mkd  set ft=mkd
au BufNewFile,BufRead ~/*/blog/* set ft=html tw=80
au BufNewFile,BufRead ~/.bash* set ft=sh
au BufNewFile,BufRead /etc/apache2/*.conf set ft=apache
au BufNewFile,BufRead /etc/apache2/sites*/* set ft=apache

augroup mkd
	autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
augroup END

"
"----------------------------------------------------------#
" Key bindings 
"----------------------------------------------------------#
nmap <F9> :!vim-ftp %<CR><CR>
map! <F9> :!vim-ftp %<CR><CR>

source ~/.vim/plist_script.vim
