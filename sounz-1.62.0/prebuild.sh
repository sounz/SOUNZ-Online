#!/bin/bash
###########################################################################
# Pre-Build script executed before dpkg-buildpackage is invoked to
# create the package files.
# P Waite, Nov 2007
#
# This script can be put anywhere you like, but normally it lives in the
# top directory of your source package.
#
###########################################################################

# Insert your custom pre-build processing here.

# Some parameters available to you:
#  $package        your package name, from debian/control
#  $package_ver    debian version being built, from debian/changelog
#  $packagesdir    directory in which the package will be built
#  $VCS            path to VCS executable, eg: /usr/bin/svn
#  $VCSTYPE        type of VCS being used, eg: Vcs-Svn
#
# There are many others (see scripts), but those are the main ones.
#
#
# The below is just an example based on the author's packaging..
#
# Provide versioning info in package /etc area if present
if [ -d etc/${package} ] ; then
  # Update the debian version
  echo "re-writing the version file with ${package_ver}"
  echo $package_ver > etc/${package}/${package}.version

  if [ "$VCSTYPE" = "Vcs-Svn" ] ; then
    # Update the Subversion revision
    svnrev=`svn info | grep Revision | awk '{print $2}'`
    echo "re-writing the SVN revision file with ${svnrev}"
    echo $svnrev > etc/${package}/${package}.svn
  fi

  # Update a changes file too
  echo "re-writing the changes file"
  $DPKG_PARSECHANGELOG | ./scripts/snippet.pl -s "^Changes" > etc/${package}/${package}.changes

fi


# ENDS
