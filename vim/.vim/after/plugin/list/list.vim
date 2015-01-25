" Set the list option if expandtab is set.  This helps visualize erroneous
" tabs in a file that is otherwise indented with spaces.  This is done as an
" autocommand in an 'after' plugin to ensure that it runs after vim-sleuth.
" There is quite possibly a cleaner way to do this.

augroup expandtab_list
  autocmd!
  autocmd FileType * if &expandtab | set list | end
augroup END
