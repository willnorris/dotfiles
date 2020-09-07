#!/bin/bash

sudo apt-get update
sudo apt-get -y install man

sudo chsh -s /usr/bin/zsh $USER

# install ripgrep
curl -o /tmp/ripgrep.deb -L https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i /tmp/ripgrep.deb

# install bat
curl -o /tmp/bat.deb -L https://github.com/sharkdp/bat/releases/download/v0.15.4/bat_0.15.4_amd64.deb
sudo dpkg -i /tmp/bat.deb

# setup rcm config if not present
if [ ! -f "${HOME}/.rcrc" ]; then
  cp "${HOME}/.dotfiles/rcrc.example" "${HOME}/.rcrc"
fi

echo 'TAGS="codespaces"' >> ~/.rcrc
# run rcm (force install dotfiles)
PATH="${HOME}/.dotfiles/rcm/bin:${PATH}" rcup -f
