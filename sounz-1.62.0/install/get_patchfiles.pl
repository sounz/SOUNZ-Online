#!/usr/bin/perl
#
# Returns a list of files to be patched, which have a patch code
# of a greater lexical value than the code passed in as second
# parameter. The final line returned always contains the patch
# code for the highest patch file - this would be the next
# 'last patch code' which could be passed in here next time.
#
# NOTES: patch files are assumed to be named in the format:
#          upgrade_N.N.N_to_N.N.N.sql
#  where N can be any integer.
#
# usage:
# ./get_patchfiles.pl <path to patchfiles> <last patch code>
#
# example:
# ./get_patchfiles.pl /path/to/patches 000100000003-000100000004
#
use File::Path;

my $patchdir = $ARGV[0];
my $patchfrom = $ARGV[1];

my $patchH;
my @upgradefiles = ();
my @patchfiles = ();
my %patches = ();
my $patch = '';

unless ( opendir $patchH, $patchdir ) {
  die("can't read patch directory '$patchdir'");
}

@upgradefiles = grep /upgrade.*\.sql/, readdir $patchH;
closedir $patchH;
if ( scalar(@upgradefiles) == 0 ) {
  exit 0;
}

foreach(@upgradefiles) {
  next unless /^upgrade_(\d+)\.(\d+)\.(\d+)_to_(\d+)\.(\d+)\.(\d+).sql$/;
  $patch = sprintf('%04d%04d%04d-%04d%04d%04d', $1, $2, $3, $4, $5, $6);
  if ($patch gt $patchfrom) {
    $patches{$patch} = $_;
  }
}

if (scalar(keys %patches) > 0) {
  my $lastpatch;
  foreach $patch (sort keys %patches) {
    print $patches{$patch}, "\n";
    $lastpatch = $patch;
  }
  print "$lastpatch\n";
}

1;