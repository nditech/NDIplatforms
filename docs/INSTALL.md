NDI PLATFORMS
=============

Download NDIplatforms
---------------------

Download NDIplatforms somewhere convenient, such as:

    $ git clone https://github.com/nditech/NDIplatforms.git ~/makefiles/NDIplatforms


Install Drush 7.x
-----------------

To use the latest version of NDIplatforms effectively, you need a recent version
of Drush, as well as a custom Drush extension.  As such, we recommend using a
local Drush install, so as not to interfere with other Drush functionality on
the server.

    $ git clone --branch 7.x https://github.com/drush-ops/drush.git ~/drush7
    $ cd ~/drush7
    $ curl -sS https://getcomposer.org/installer | php
    $ php ./composer.phar install
    $ alias drush7="~/drush7/drush"

You can test whether the "drush7" alias is working like so:

    $ drush7 status
     PHP configuration      :  /etc/php5/cli/php.ini
     PHP OS                 :  Linux
     Drush version          :  7.0-dev
     Drush temp directory   :  /tmp
     Drush configuration    :
     Drush alias files      :

If you are running PHP with the suhosin module, you may have to pass the PHP
CLI an option to allow .phar files:

    -d suhosin.executor.include.whitelist=phar


Install make_diff
-----------------

The "make_diff" extension allows two makefiles to be compared easily. To
install it, simply run the following command:

    $ drush dl make_diff

