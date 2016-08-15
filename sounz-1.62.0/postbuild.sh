#!/bin/bash
###########################################################################
# Post-Build script executed after dpkg-buildpackage is invoked to
# create the package files.
# P Waite, Nov 2007
#
# This script can be put anywhere you like, but normally it lives in the
# top directory of your source package.
#
###########################################################################
# What this script is doing

# Insert your custom post-build processing here
#
# Some parameters available to you:
#  $package        your package name, from debian/control
#  $package_ver    debian version being built, from debian/changelog
#  $packagesdir    directory in which the package will be built
#  $VCS            path to VCS executable, eg: /usr/bin/svn
#  $VCSTYPE        type of VCS being used, eg: Vcs-Svn
#
# There are many others (see scripts), but those are the main ones.
#

# ENDS