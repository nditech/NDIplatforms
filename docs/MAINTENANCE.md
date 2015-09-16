NDI PLATFORMS
=============

This document describes how to maintain lock makefiles. To understand how to
build platforms using them, please see USAGE.md. To better understand how these
makefiles are structured, please see STRUCTURE.md.

Please follow the installation instructions in INSTALL.md, as we currently use
git versions of both Drush and an extension, make_diff. The usage instructions
below assume that you have followed those instructions exactly.


MAINTENANCE
-----------

For simplicity, we use the stubs/ndi-common.make makefile in our examples.
Obviously, replace this with whichever platform stub makefile is appropriate.


1. Update your makefiles
------------------------

First, we create a temporary lockfile based on a given platform stub:

    $ drush7 make --no-build --lock=/tmp/make.lock stubs/ndi-common.make
    Wrote .make file /tmp/make.lock

Note: the --lock parameter does not work with the ~ path shortcut.

Then, we compare it to the current lockfile, so we can see what changes have
occurred:

    $ drush7 diff locks/ndi-common.lock /tmp/make.lock --list=0
     Project  Old version  New version  Notices                            
     drupal   7.38         7.39         version upgraded, patches changed.

Investigate and fix any warnings as appropriate. This will generally involve
pinning a version for a module. This is done by commenting out the module from
the general modules list (i.e., includes/modules.make), then adding an entry
in the modules pin list (i.e., /includes/modules/pins.make):

    ; The recommended release is on the 2.x branch, so we pin to the latest
    ; supported version on the 1.x branch.
    ; For updates, check: https://drupal.org/project/google_analytics
    projects[goole_analytics][version] = 1

It is usually best to pin to a major version in this case, so that new releases
on that branch are incorporated automatically.

Re-running the commands above should now no longer show any major version
upgrade warnings.


Test the new lockfile
---------------------

It is usually worthwhile to test the new lockfile at this point. For example,
an update to a module could cause a patch to no longer apply. Usually, in such
cases, updating the patches makefile with a new patch, or simply removing
patches that have been incorporated into the new release will be sufficient to
resolve any issues at this stage.

Adding or changing patches or libraries, adding new modules or themes, and
other such modifications can also cause build failures. Running a test build is
as simple as running drush make on the new lockfile:

    $ drush7 make /tmp/make.lock test_demtools


Finalize the new lockfile
-------------------------

Once all changes and warnings are resolved or accepted, and documented, we copy
the temporary lockfile over the existing one in our repo:

    $ cp /tmp/make.lock locks/ndi-common.lock

Then commit these changes into git:

    $ git commit -am"Update NDI's common platform."

It may also be useful to include the output of `drush make-diff` in the commit
message.
