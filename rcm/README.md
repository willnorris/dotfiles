This directory provides a local installation of
<https://github.com/thoughtbot/rcm>. Because rcm is just a collection of bash
scripts, it is already quite small and portable. Rather than requiring that it
be installed on each host machine, I just bundle it here as part of my dotfiles
repo.

To update this local installation from the upstream source:

    git clone https://github.com/thoughtbot/rcm /tmp/rcm
    cd /tmp/rcm

    ./configure --prefix ~/.dotfiles/rcm
    make
    make install

    gzip ~/.dotfiles/rcm/share/man/**/*
