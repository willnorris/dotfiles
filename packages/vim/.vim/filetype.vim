" filetype detection
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufNewFile,BufRead  *.{phps,phtml}  setfiletype php
  au! BufRead,BufNewFile *.mkd            setfiletype mkd
  au! BufRead,BufNewFile *.xmlt           setfiletype xml
  au! BufRead,BufNewFile *.ezt            setfiletype html
  au! BufRead,BufNewFile *.tml            setfiletype html
  au! BufNewFile,BufRead *.json           setfiletype javascript
  au! BufNewFile,BufRead *.jsont          setfiletype javascript
  au! BufNewFile,BufRead */.bash*         setfiletype sh
  au! BufNewFile,BufRead */.bash/*        setfiletype sh
  au! BufNewFile,BufRead */.mutt*         setfiletype muttrc
  au! BufNewFile,BufRead /etc/apache2/*.conf    setfiletype apache
  au! BufNewFile,BufRead /etc/apache2/sites*/*  setfiletype apache

  au! BufNewFile,BufRead */google3/*.api  setfiletype proto
  au! BufNewFile,BufRead *.{proto,rosy}  setfiletype proto
augroup END
