# willnorris/dotfiles

This repository contains my dotfiles for various applications.

Installation of these files is managed by [rcm],
which I've actually bundled as part of my dotfiles in the [vendor/rcm] directory.

[rcm]: https://github.com/thoughtbot/rcm
[vendor/rcm]: ./vendor/rcm

To set up a new host:

- `git clone https://github.com/willnorris/dotfiles $HOME/.dotfiles`
- `./.dotfiles/install.sh`

## Work dotfiles

I have a separate set of dotfiles for my work machines.
They include things like additional shell aliases and configuration files for internal tools.

- `git clone git@github.com:willnorris/work-dotfiles ~/.work-dotfiles`
- update `~/.config/rcm/rcrc` to include:

      DOTFILES_DIRS="${HOME}/.dotfiles ${HOME}/.work-dotfiles"

`rcup` will now install my work-specific dotfiles alongside my regular ones.

## Vendored tools and scripts

Some tools and scripts are directly imported from other locations.
They can be found in the [vendor](vendor) directory along with their individual licenses.
