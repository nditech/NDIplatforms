USAGE [![Build status](https://travis-ci.org/nditech/NDIplatforms.svg)](https://travis-ci.org/nditech/NDIplatforms)
=====

This section describes building platforms using the NDIplatforms stub Drush
makefiles. To understand how these makefiles are maintained, please see
the [Maintenance](maintenance.md) section.


GNU Make
--------

While most of Drupal platform creation refers to Drush makefiles, this project
includes a [GNU Makefile](https://www.gnu.org/software/make/) to simplify its
usage. To see what commands are available, run:

    :::bash
    $ make list


For simplicity, we use the "demtools/dkan" platform in our examples. Obviously,
replace this with whichever platform stub makefile is appropriate.


Test a platform build
---------------------

Before proceeding with deploying a platform for production use, it can be
useful to run a test build, to see if there are any errors in the lockfile.
Note that we run [automated tests](https://travis-ci.org/nditech/NDIplatforms)
to build the DemTools platforms after each code push to the NDIplatforms
project. However, changes to included project (e.g., reference git branch
deleted) since then might cause a build to break.

To run a test build, simply run:

    :::bash
    $ make demtools/dkan-test
    Beginning to build makefiles/demtools/dkan/lock.yml.                 [ok]
    drupal-7.43 downloaded.                                              [ok]
    [...]

Each DemTools platform (demtools/dkan, demtools/civicrm, etc.) have such a test
command defined (although it may not show up in the `make list` output).

Note that running such a test will re-compile any relevant lockfiles whose
sources have changed. See the [Structure](structure.md) and
[Maintenance](maintenance.md) sections for further details.


Build a platform
----------------

The easiest way to build a platform is to use the provided Make commands:

    :::bash
    $ make demtools/dkan-platform
    Beginning to build makefiles/demtools/dkan/lock.yml.                 [ok]
    drupal-7.43 downloaded.                                              [ok]
    [...]

Each DemTools platform (demtools/dkan, demtools/civicrm, etc.) has such a
platform build command defined (although it may not show up in the `make list`
output).

This command will build the platform to the usual production path on a stock
Aegir system, create an Aegir "context" (Drush alias), and import the resulting
platform into the Aegir front-end.

The resulting platform will incorporate a date-stamp to make it simple to see
which is the most current. If multiple platforms of the same type are required
during the course of a single day (e.g., for iterative bug fixing and testing),
we can include a revision counter to keep platforms and aliases unique. To do
so, simply add `inc=<suffix>` when calling the platform build command:

    :::bash
    $ make demtools/dkan-platform inc=a
    Beginning to build makefiles/demtools/dkan/lock.yml.                 [ok]
    drupal-7.43 downloaded.                                              [ok]
    [...]


Build a platform on the command-line
------------------------------------

To build a platform (also referred to as a code-base), we can also use Drush
Make directly, along with our lockfiles. We start by simply calling Drush make
(usually as the "aegir" user):

    :::bash
    $ drush make ~/makefiles/NDIplatforms/makefiles/demtools/dkan/lock.yml ~/platforms/DemTools_DKAN_2016-02-22
    Beginning to build makefiles/demtools/dkan/lock.yml.                 [ok]
    drupal-7.43 downloaded.                                              [ok]
    [...]

Assuming that the platform build worked, we then need to tell Aegir about it.
The easiest way to do that is to visit `/node/add/platform` on the Aegir site.
We then need to provide a name, such as "DemTools_DKAN_2016-02-22", and specify
the path where we built it.

This can also be accomplished at the command-line by running the provision-save
and hosting-import Drush commands provided by Aegir. However, this is a very
advanced technique which we will not cover here.  Use the "--help" option with
these commands to see how they work, or check out our use in the Makefile that
ships with NDIplatforms.


Build a platform in the Aegir UI
--------------------------------

Alternatively, we can build the platform directly from within the Aegir UI.
This is the preferred method, as it:

  * makes the output of the platform build available in the task log;
  * creates a link to the makefile that was used in building the platform; and
  * avoids having to import the platform separately.

However, YAML-formatted makefiles require Drush 8, which only shipped with
Aegir Debian packages starting in version 3.4. As a result, building from the
command line may be required, if you are using an older version.

First, find the lockfile we want to use to build the platform on Github. Visit
the [NDIplatforms project on GitHub](https://github.com/nditech/NDIplatforms).
From here, we'll want to work from the latest commit, as this will allow us to
specify the commit hash in the makefile path. The benefit of doing so, is that
we'll know *exactly* what the makefile contained at the time that we buil this
platform. This can turn out to be very useful later.

Either follow the "Latest commit" link, or append
[/commit/HEAD](https://github.com/nditech/NDIplatforms/commit/HEAD) to the
project URL. We'll start seeing a long commit hash is subsequently. Click on
the "Browse files" link to get back to the tree view of the project. Then
navigate into the `makefiles/demtools/` directory, and choose which DemTools
platform to build.

In this directory, we'll find a `lock.yml` file. This will show all the
components that will be pulled together to form the platform.  Next, click the
"Raw" button to get a link to the output that Drush Make can
accept. Here's an example of such a URL:

* [https://raw.githubusercontent.com/nditech/NDIplatforms/5f93ef3c183574a79a7132bfce865e3f76894235/makefiles/demtools/dkan/lock.yml](https://raw.githubusercontent.com/nditech/NDIplatforms/5f93ef3c183574a79a7132bfce865e3f76894235/makefiles/demtools/dkan/lock.yml)

Copy that URL into the "makefile" field on "/node/add/platform" on the
Aegir site. Then provide a meaningful name, such as "DemTools_2016-02-25", and
click "Save".

That should be all that is required. In the background, Aegir will download the
makefile, run Drush Make, and register the platform. You should see a link to
the makefile used in creating the platform. This is useful to determine the
exact platform contents, or for re-creating the platform elsewhere, such as on
a different server.

