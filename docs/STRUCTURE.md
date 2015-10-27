NDI PLATFORMS
=============

This document describes the filesystem layout for NDIplatforms makefiles.
To understand how to use them to build platforms, please see docs/USAGE.md.
To better understand how these makefiles are maintained, please see
docs/MAINTENANCE.md.


STRUCTURE
---------

For simplicity, we are limiting our discussion to the ndi-civisociety platform.
Several more platforms may be included in NDIplatforms, and this system scales
very well.  However, listing them all here would complicate explanations.


Filesystem layout
-----------------

Drush makefiles allow for the inclusion of other makefiles.  In order to reduce
duplication and encourage these makefiles to be self-documenting, NDIplatforms
makes extensive use of makefile includes.

Here is the (abridged) layout of files and directories:

    $ tree
    .
    ├── docs
    │   ...
    ├── includes
    │   ├── civicrm-extensions.make
    │   ├── civicrm.make
    │   ├── core.make
    │   ├── modules.make
    │   └── ndi-civi-extensions.make
    ├── locks
    │   └── ndi-civisociety.lock
    ├── README.md
    └── stubs
        ├── civicrm.make
        └── ndi-civisociety.make

There are 4 top-level directories: docs, includes, locks and stubs.  We examine
these in more detail later.  The locks and stubs directories simply contain
lockfiles and release notes in the former, and stub makefiles in the latter,
with no further hierarchy.

The "includes" directory, on the other hand, may have subdirectories, though it
currently does not.


Stubs
-----

Stubs are makefiles that usually do not contain any projects to download
directly.  Instead, they usually include a version of core, and various other
makefiles to build up a full platform.

In the example below, we see that the contents are pretty basic.  There is
documentation throughout, as well as the basic Drush make "api" and "core"
elements.  We also set a default sub-directory within which to download
projects.  This allows us to keep our included makefiles cleaner.

We then include a core makefile, module, civicrm, and extensions makefiles and a
theme makefile.  Note that we specify the location of the include file relative
to the location of the stub.

    core = 7.x
    api = 2

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;               Core               ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    includes[] = ../includes/core.make

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;             Defaults             ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ; Specify common subdir
    defaults[projects][subdir] = "contrib"

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;         Released Modules         ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    includes[] = ../includes/modules.make

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;           CiviCRM core           ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    includes[] = ../includes/civicrm.make

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;        CiviCRM Extensions        ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    includes[] = ../includes/civicrm-extensions.make


Includes
--------

In the includes directory we find a core makefile that includes a core
distribution and any patches we need to apply to Drupal.  These included
makefiles have standard headers similar to the stub makefile above.

In modules.make, we have a general list of modules.  This makefile lists all
the modules that will be downloaded as part of the platform.  We segment
related modules into their own dedicated makefiles, if this helps organization
or re-use.


Lockfiles
---------

Finally, the lockfiles directory includes makefiles that have been run through
"drush make --lock --no-build" (see docs/MAINTENANCE.md).  This basically takes our
stub makefile, compiles all the inclusions, and then checks with drupal.org to
determine the latest versions of all the components, just as if they were all
going to be downloaded in a normal run of Drush make.  It then writes this out
into a new makefile that now specifies all the up-to-date versions.  This form
of makefile is called a lockfile, similar to what we see with Composer or Gem.

