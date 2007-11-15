"" ============================================================================
""   ~/.vim/ftplugin/mail_rem_sig.vim
""   (adapted from Cedric Duval's ~/.vim/mail)
"" ============================================================================


"" ----------------------------------------------------------------------------
""   Suppressing quoted signature(s) if any when replying
"" ----------------------------------------------------------------------------
function! Mail_Erase_Sig()
  " search for the signature pattern (takes into account signature delimiters
  " from broken mailers that forget the space after the two dashes)
  let i = 0
  while ((i <= line('$')) && (getline(i) !~ '^> *-- \=$'))
    let i = i + 1
  endwhile

  " if found, then
  if (i != line('$') + 1)
    " first, look for our own signature, to avoid deleting it
    let j = i
    while (j < line('$') && (getline(j + 1) !~ '^-- $'))
      let j = j + 1
    endwhile

    " second, search for the last non empty (non sig) line
    while ((i > 0) && (getline(i - 1) =~ '^\(>\s*\)*$'))
      let i = i - 1
    endwhile

    " third, delete those lines plus the signature
    exe 'normal '.i.'Gd'.(j-2).'G'
  endif
endfunction


"" ----------------------------------------------------------------------------
""   Replacing empty quoted lines (e.g. "> $") with empty lines
""   (convenient to automatically reformat one paragraph)
"" ----------------------------------------------------------------------------
function! Mail_Del_Empty_Quoted()
  exe "normal :%s/^>[[:space:]\%\|\#>]\\+$//e\<CR>"
endfunction



"" ----------------------------------------------------------------------------
""   Moving the cursor at the begining of the mail
"" ----------------------------------------------------------------------------
function! Mail_Begining()
  exe "normal gg"
  if getline (line ('.')) =~ '^From: '
    " if we use edit_headers in Mutt, then go after the headers
    exe "normal /^$\<CR>"
  endif
endfunction



"" ----------------------------------------------------------------------------
""
""   Initializations
""
"" ----------------------------------------------------------------------------

call Mail_Erase_Sig()
call Mail_Del_Empty_Quoted()
"call Mail_Begining()
