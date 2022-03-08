#!/bin/bash

USERNAME=$(whoami)

sudo apt-get update
sudo apt-get -y install man

sudo chsh -s /usr/bin/zsh $USERNAME

# install ripgrep (https://github.com/BurntSushi/ripgrep/releases/latest)
curl -o /tmp/ripgrep.deb -L https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i /tmp/ripgrep.deb

# install bat (https://github.com/sharkdp/bat/releases/latest)
curl -o /tmp/bat.deb -L https://github.com/sharkdp/bat/releases/download/v0.18.3/bat_0.18.3_amd64.deb
sudo dpkg -i /tmp/bat.deb

# install neovim
curl -o /tmp/nvim.tgz -L https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
sudo tar -xzf /tmp/nvim.tgz -C /usr/local
sudo ln -s /usr/local/nvim-linux64/bin/nvim /usr/local/bin/

# run rcm (force install dotfiles)
PATH="${HOME}/.dotfiles/local/bin:${PATH}" rcup -f -t codespaces
