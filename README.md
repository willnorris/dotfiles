This repository contains my dotfiles for various applications.

Installation of these files is managed by [rcm][], which I've actually bundled
as part of my dotfiles in the [rcm](./rcm/) directory.

[rcm]: https://github.com/thoughtbot/rcm

To set up a new host:

* `git clone https://github.com/willnorris/dotfiles ~/.dotfiles`
* `PATH="~/.dotfiles/rcm/bin:$PATH" rcup`

## Work dotfiles

For my work machines, I have a separate set of dotfiles that I store on an
internal git server. They include things like additional shell aliases and
configuration files for internal tools. For those that have access, they can
be found at <http://go/user.git/willnorris/dotfiles>. They are installed
using:

* `git clone sso://user/willnorris/dotfiles ~/.dotfiles-work`
* update `~/.rcrc` to include `DOTFILES_DIRS="${HOME}/.dotfiles-work ${HOME}/.dotfiles"`

`rcup` will now install my work-specific dotfiles alongside my regular ones.

## License

I'm not sure that many of the files here would constitute a creative work able
to be covered by copyright. But to the extent that they are, unless otherwise
noted, they are made available under a [0BSD license](./LICENSE).
