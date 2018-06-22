INSTALLATION [![Build status](https://travis-ci.org/nditech/NDIplatforms.svg)](https://travis-ci.org/nditech/NDIplatforms)
============

Download
--------

Download NDIplatforms somewhere convenient, such as:

    :::console
    $ git clone --recursive https://github.com/nditech/NDIplatforms.git ~/makefiles/NDIplatforms
    $ cd ~/makefiles/NDIplatforms


Install
-------

To use the latest version of NDIplatforms effectively, you need a recent
version of Drush. If you don't have Drush 8 installed on the server, you can
use [Drumkit](http://drumk.it) (included as a git sub-module) to quickly
install a local version of Drush:

    :::console
    $ make drush
    [...]
    Installing the 8.1.2 release of Drush.
     Drush Version   :  8.1.2 

Then, to make it available on the command-line, you can add the local binary
directory to your $PATH by bootstrapping Drumkit:

    :::console
    $ . d

Note that we're `sourcing` a file, which will change your environment. This
will only last for the current session. If you login to a new terminal session,
you'll need to re-run `. d`.

