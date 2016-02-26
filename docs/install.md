INSTALLATION [![Build status](https://travis-ci.org/nditech/NDIplatforms.svg)](https://travis-ci.org/nditech/NDIplatforms)
============

Download
--------

Download NDIplatforms somewhere convenient, such as:

    :::console
    $ git clone https://github.com/nditech/NDIplatforms.git ~/makefiles/NDIplatforms
    $ cd ~/makefiles/NDIplatforms


Install
-------

To use the latest version of NDIplatforms effectively, you need a recent version
of Drush. As such, we recommend using a local Drush install, so as not to
interfere with other Drush functionality on the server.

There are various options available, that are explained further in the next
section. Use the following command to install the recommended version of Drush:

    :::console
    $ make install
    Switched to branch 'dev/2000'
    [...]
     Drush git branch: dev/2000


### Install Drush

If you prefer to use the latest release of Drush:

    :::console
    $ make drush
     Drush Version   :  8.0.3

Alternatively, you might want to use the latest (unstable) Drush development
build:

    :::console
    $ make drush-unstable
     Drush Version   :  8.1-dev

You could also deploy Drush from source code:

    :::console
    $ make drush-source
    Already on 'master'
    [...]
    All settings correct for using Composer
    Downloading...
    [...]
     Drush Version   :  8.1-dev

Finally, deploying Drush from source code allows the use of arbitrary branches
(from a PR, for example):

    :::console
    $ make drush-source branch=dev/2000
    Switched to branch 'dev/2000'
    [...]
     Drush git branch: dev/2000

