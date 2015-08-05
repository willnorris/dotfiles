This repositry contains my dot-files for various applications, structured as
[homedir][] packages.

[homedir]: https://github.com/docwhat/homedir

Note to self: setup on a new host using:

    curl -L https://github.com/docwhat/homedir/raw/master/lib/homedir/setup.py | python
    cd $HOME/.homedir/packages
    git clone git@github.com:willnorris/dotfiles.git personal
    cd personal
    git submodule init
    git submodule update

Or for read-only:

    curl -L https://github.com/docwhat/homedir/raw/master/lib/homedir/setup.py | python
    cd $HOME/.homedir/packages
    git clone https://github.com/willnorris/dotfiles.git personal
    cd personal
    git submodule init
    git submodule update


## License

I'm not sure that many of the files here would constitute a creative work able
to be covered by copyright.  But to the extent that they are, unless otherwise
noted, they are made available under an [Apache 2.0 license](./LICENSE).
