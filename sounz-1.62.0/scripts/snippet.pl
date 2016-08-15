#!/usr/bin/perl -w
#
# Extract a snippet from a file
# P Waite Nov 2007
#
# This script gets it's input from STDIN and takes controlling parameters
# on the command line as described below.
#
# The script will ignore lines until the first pattern is matched. It
# will then copy lines to STDOUT until the second pattern is matched
# or until end-of-file if no second pattern is given.
#
# The patterns are normal perl regex.
#
# Parameters:
#  -s <start pattern>   - Start snippet match regex
#  -e <end pattern>     - End snippet match regex
#  -x                   - Exclude match lines
#
# NOTE: If no -s and -e are given, then the whole file will be printed,
# rather than raising an error.
#
# example of usage:
#   cat myfile | snippet.pl -s "foo" -e "bar" -x
#
#   the above example would print a snippet from the file 'myfile' which
#   starts on a line containing "foo", and ends on a line which
#   contains "bar", and will exclude the matching lines.
#
use Getopt::Std;
getopts('s:e:x');

# options
$opt_s = "" unless defined $opt_s;
$opt_e = "" unless defined $opt_e;
$opt_x = 0  unless defined $opt_x;

# vars..
my $line = "";
my $snippet = 0;

# Print snippet extract from stdin
SNIPPET:
  while (<>) {
    $line = $_;
    if (!$snippet) {
      if ($opt_s ne "" && $line =~ /$opt_s/) {
        print $line if !$opt_x;
        $snippet = 1;
      }
    }
    else {
      if ($opt_e ne "" && $line =~ /$opt_e/) {
        print $line unless $opt_x;
        last SNIPPET;
      }
      else {
        print $line;
      }
    }
  } # while

# END