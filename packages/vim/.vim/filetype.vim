" filetype detection
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufNewFile,BufRead  *.{phps,phtml}  setfiletype php
  au! BufRead,BufNewFile *.mkd   setfiletype mkd
  au! BufRead,BufNewFile *.xmlt   setfiletype xml
  au! BufNewFile,BufRead *.json setfiletype json
  au! BufNewFile,BufRead */.bash* setfiletype sh
  au! BufNewFile,BufRead */.bash/* setfiletype sh
  au! BufNewFile,BufRead */.mutt* setfiletype muttrc
  au! BufNewFile,BufRead /etc/apache2/*.conf setfiletype apache
  au! BufNewFile,BufRead /etc/apache2/sites*/* setfiletype apache
augroup END
