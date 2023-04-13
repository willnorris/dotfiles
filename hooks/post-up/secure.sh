#!/usr/bin/env bash

. "${HOME}/.config/shell/_base.sh"

HOST=$(hostname | cut -d. -f1)

function link_secure() {
  link_file "${HOME}/.secure/${1}" "${HOME}/${2}"
}

link_secure "gpg/pubring.gpg"                   ".gnupg/pubring.gpg"
link_secure "gpg/private-keys-v1.d"             ".gnupg/private-keys-v1.d"
link_secure "mutt/credentials"                  ".config/neomutt/credentials"
link_secure "mysql/${HOST}.cnf"                 ".my.cnf"
link_secure "netrc/${HOST}.netrc"               ".netrc"
link_secure "rclone/wjn730-b321c955b53f.json"   ".config/rclone/wjn730-b321c955b53f.json"
