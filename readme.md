# Homedir #

[Homedir][] is a project developed by Christian "[docwhat](/docwhat)" Höltje
which allows for "controlling the contents of your home directory via a version
control system in a sane way".

Within this repositry you will find all of my various dot-files for
applications like bash, vim, git, mutt, etc.  Feel free to peruse them and take
whatever is useful for you.  My bash files are most certainly the most
interesting.  I [blogged about my setup][] back in 2005, and amazingly not that
much has changed since then.  I could certainly stand to do a better job
explaining it though.

[Homedir]: https://github.com/docwhat/homedir
[blogged about my setup]: http://willnorris.com/2005/03/bashrc

Note to self: setup on a new host using:

    curl -L https://github.com/docwhat/homedir/raw/master/lib/homedir/setup.py | python
    cd $HOME/.homedir/packages
    git clone git@github.com:willnorris/homedir-packages.git personal

    # or for read-only
    curl -L https://github.com/docwhat/homedir/raw/master/lib/homedir/setup.py | python
    cd $HOME/.homedir/packages
    git clone git://github.com/willnorris/homedir-packages.git

<!-- vim: set ft=mkd :-->
