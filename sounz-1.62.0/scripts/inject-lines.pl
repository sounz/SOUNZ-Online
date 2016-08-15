#!/usr/bin/perl -w
#
# Inject lines into a file
#
# This script takes three (mandatory) parameters on the command line. The
# first is the full path to the file to inject the lines into. The second
# is the name of a file containing the lines to inject, and the third is
# a perl regex to match the line below which to inject the new lines.
#
# Parameters:
#  1 - Path to target file to inject into
#  2 - Path to source file for lines to inject
#  3 - Perl regex, match line in target and new lines are injected below
#
# Usage: inject-lines.pl /etc/myconf /tmp/newlines "foo"
# would inject lines from /tmp/newlines into /etc/myconf and the lines
# will be put below the first line in /etc/myconf which matches the
# pattern 'foo'. No match, no injection.
#
my $TARGET_FILE = $ARGV[0];
my $NEWLINES_FILE = $ARGV[1];
my $pattern = $ARGV[2];

# vars..
my $done = 0;
my $tmp = "/tmp/" . "inj" . $$;

if (open TARG, "<$TARGET_FILE") {
  if (open TMP, ">$tmp" ) {
    while (<TARG>) {
      if ($done == 0) {
        if (/$pattern/) {
          print TMP;
          if (open SRC, "<$NEWLINES_FILE") {
            while (<SRC>) {
              print TMP;
            }
            close SRC;
            $done = 1;
          }
        }
        else {
          print TMP;
        }
      }
      else {
        print TMP;
      }
    } # while
    close TMP;
  }
  close TARG;
  # Copy over original if done
  if ($done == 1) {
    my @copycmd = ("cp", $tmp, $TARGET_FILE);
    if (system(@copycmd) == 0) {
      $ret = 0;
    }
    else {
      $ret = 2;
    }
  }
  else {
    $ret = 1;
  }
  # Tidy up..
  unlink $tmp;
}

# exit with return code
exit $ret;