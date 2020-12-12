#!/bin/bash

sudo apt-get update
sudo apt-get -y install man

sudo chsh -s /usr/bin/zsh codespace

# install ripgrep
curl -o /tmp/ripgrep.deb -L https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
sudo dpkg -i /tmp/ripgrep.deb

# install bat
curl -o /tmp/bat.deb -L https://github.com/sharkdp/bat/releases/download/v0.17.1/bat_0.17.1_amd64.deb
sudo dpkg -i /tmp/bat.deb

# install neovim
curl -o /tmp/nvim.tgz -L https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
sudo tar -xzf /tmp/nvim.tgz -C /usr/local
sudo ln -s /usr/local/nvim-linux64/bin/nvim /usr/local/bin/

# setup rcm config if not present
if [ ! -f "${HOME}/.rcrc" ]; then
  cp "${HOME}/.dotfiles/rcrc.example" "${HOME}/.rcrc"
fi

echo 'TAGS="codespaces"' >> ~/.rcrc
# run rcm (force install dotfiles)
PATH="${HOME}/.dotfiles/rcm/bin:${PATH}" rcup -f
