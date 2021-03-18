" filetype detection
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufNewFile,BufRead */.bash*         setfiletype sh
  au! BufNewFile,BufRead */.config/bash/* setfiletype sh
  au! BufNewFile,BufRead */.config/zsh/*  setfiletype zsh
  au! BufNewFile,BufRead */.mutt*         setfiletype muttrc
  au! BufNewFile,BufRead */etc/apache2/*  setfiletype apache
  au! BufNewFile,BufRead */etc/nginx*.conf  setfiletype nginx
  au! BufNewFile,BufRead /etc/nginx/sites/*  setfiletype nginx
augroup END
