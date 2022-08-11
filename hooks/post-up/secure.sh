#!/usr/bin/env bash

HOST=$(hostname | cut -d. -f1)

function install_file() {
  SRC="${HOME}/.secure/${1}"
  DST="${HOME}/${2}"

  if [ -r "${SRC}" ]; then
    if [ ! -h "${DST}" ] || [ "$(readlink "${DST}")" != "${SRC}" ]; then
      mkdir -p "$(dirname "${DST}")"
      ln -s "${SRC}" "${DST}"
    fi
  fi
}

install_file "gmvault/token.sec"                 ".gmvault/token.sec"
install_file "gmvault/wnorris@gmail.com.passwd"  ".gmvault/wnorris@gmail.com.passwd"
install_file "gpg/pubring.gpg"                   ".gnupg/pubring.gpg"
install_file "gpg/private-keys-v1.d"             ".gnupg/private-keys-v1.d"
install_file "mutt/credentials"                  ".mutt/credentials"
install_file "mysql/${HOST}.cnf"                 ".my.cnf"
install_file "netrc/${HOST}.netrc"               ".netrc"
install_file "rclone/wjn730-b321c955b53f.json"   ".config/rclone/wjn730-b321c955b53f.json"
