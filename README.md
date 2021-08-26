# willnorris/dotfiles

This repository contains my dotfiles for various applications.

Installation of these files is managed by [rcm][], which I've actually bundled
as part of my dotfiles in the [rcm](./rcm/) directory.

[rcm]: https://github.com/thoughtbot/rcm

To set up a new host:

* `git clone https://github.com/willnorris/dotfiles $HOME/.dotfiles`
* `PATH="$HOME/.dotfiles/rcm/bin:$PATH" rcup`

## Work dotfiles

For my work machines, I have a separate set of dotfiles that I store on an
internal git server. They include things like additional shell aliases and
configuration files for internal tools. For those that have access, they can
be found at <http://go/dotfiles/users/wnorris>. They are installed
using:

* `git clone https://git.internal/dotfiles ~/.dotfiles-work`
* update `~/.rcrc` to include:

      DOTFILES_DIRS="${HOME}/.dotfiles-work/users/wnorris ${HOME}/.dotfiles"

`rcup` will now install my work-specific dotfiles alongside my regular ones.

## Vendored tools and scripts

Some tools and scripts are directly imported from other locations.  They each
have their own license.

- [config/shell/z.sh](config/shell/z.sh) is from [rupa/z](https://github.com/rupa/z/blob/master/z.sh)
- [config/vim/bundle/osc52/plugin/osc52.vim](config/vim/bundle/osc52/plugin/osc52.vim) is from [Chromium](https://chromium.googlesource.com/apps/libapps/+/HEAD/hterm/etc/osc52.vim)
- [config/zsh/functions/async](config/zsh/functions/async) is from [sindresorhus/pure](https://github.com/sindresorhus/pure/blob/main/async.zsh)
- [config/zsh/functions/prompt_pure_setup](config/zsh/functions/prompt_pure_setup) is from [sindresorhus/pure](https://github.com/sindresorhus/pure/blob/main/pure.zsh) with some local modifications
- [local/bin/clip](local/bin/clip) is from [Chromium](https://chromium.googlesource.com/apps/libapps/+/HEAD/hterm/etc/osc52.sh)
- [local/bin/notify](local/bin/notify) is from [Chromium](https://chromium.googlesource.com/apps/libapps/+/HEAD/hterm/etc/hterm-notify.sh)
- [local/bin/terminal-colors](local/bin/terminal-colors) is from [eikenb/terminal-colors](https://github.com/eikenb/terminal-colors/blob/master/terminal-colors)
- [rcm](rcm) is from [thoughtbot/rcm](https://github.com/thoughtbot/rcm)
