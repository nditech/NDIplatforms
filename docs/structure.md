STRUCTURE [![Build status](https://travis-ci.org/nditech/NDIplatforms.svg)](https://travis-ci.org/nditech/NDIplatforms)
=========

This section describes the filesystem layout for NDIplatforms Drush makefiles.
To understand how to use them to build platforms, please see the
[Usage](usage.md) section. To better understand how these makefiles are
maintained, please see the [Maintenance](maintenance.md) section.


Filesystem layout
-----------------

For simplicity, we are limiting our discussion to the DemTools Civi and DKAN
platforms. Several more platforms will be included in NDIplatforms, and this
system scales very well. However, listing them all here would complicate
explanations.

Drush makefiles allow for the inclusion of other makefiles. In order to reduce
duplication and encourage these makefiles to be self-documenting, NDIplatforms
makes extensive use of makefile includes.

Here is the layout of `makefiles/` directory:

    :::console
    $ tree makefiles
    makefiles/
    ├── cores
    │   ├── drupal7
    │   │   ├── build.yml
    │   │   ├── core.make.yml
    │   │   └── lock.yml
    │   └── drupal8
    │       ├── build.yml
    │       ├── core.make.yml
    │       └── lock.yml
    ├── demtools
    │   ├── civicrm
    │   │   ├── build.yml
    │   │   ├── contrib.make.yml
    │   │   ├── custom.make.yml
    │   │   └── lock.yml
    │   └── dkan
    │       ├── build.yml
    │       ├── contrib.make.yml
    │       ├── custom.make.yml
    │       └── lock.yml
    └── stock
        ├── civicrm
        │   ├── build.yml
        │   ├── contrib.make.yml
        │   └── lock.yml
        └── dkan
            ├── build.yml
            ├── lock.yml
            └── profile.make.yml
    
    9 directories, 20 files


There are 3 top-level directories: `cores/`, `stock/` and `demtools/`. `cores/`
contains various versions of Drupal. `stock/` contains basic implementations of
underlying applications: CiviCRM and DKAN. These are useful for debugging, and
isolating issues between the applications and the DemTools customizations.
Finally, `demtools/` contains the platforms used by DemTools: stock
applications plus addtional contrib and custom components.

We examine these in more detail later.

### Types of Drush makefiles

#### \*.make.yml

These Drush makefiles define projects and libraries, but normally don't specify
any versions. They are not usually used on their own. Instead they get included
in build makefiles.

#### build.yml

Build makefiles, sometimes called stubs, do not contain any actual project
definitions. Instead, they only include other makefiles (of the .make.yml
variety) that define the core, extentions, and themes used. It may also contain
overrides to the projects defined in the includes.

#### lock.yml

Lockfiles are generated from build makefiles (see the
[Maintenance](maintenance.md) section. They have versions specified for all
projects. This helps in ensuring that deployments of platforms (code-bases)
from them are repeatable.  This process takes a stub (build) makefile, compiles
all its inclusions, then checks with http://update.drupal.org to determine the
latest versions of all the components. This is then written out as a lockfile,
similar to what we see with Composer or Gem.


Cores
-----

TBD


Stock
-----

TBD


DemTools
--------

TBD

