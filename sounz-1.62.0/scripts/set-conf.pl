#!/usr/bin/perl -w
#
# Set configuration parameter in file
#
# This script takes three (mandatory) parameters on the command line. The
# first is the full path to the configuration file. The second is the name
# of a parameter in that file, and the third is the value to set it to.
#
# Parameters:
#  1 - Path to config file
#  2 - Control variable name
#  3 - Control variable value
#
# Consider a configuration file /etc/myconf with the following lines:
#
# # This is the value of variable FOO.
# # Possible values: foo|bar|other
# FOO=other
#
# Usage: set-conf.pl /etc/myconf FOO bar
# sould set 'FOO=bar' in the given configration file, if that variable
# is found in the file and 'bar' is one of the possible values which
# are listed for it (see above example file content).
#
my $CONFIG_FILE = $ARGV[0];
my $CONFIG_NAME = $ARGV[1];
my $CONFIG_VALUE = $ARGV[2];

# vars..
my $line = "";
my $possibles_line = "";
my $set = 0;
my $pattern = "^" . $CONFIG_NAME . "=.*?";
my $possibles_pattern = "^#.*?Possible values:.*";
my $tmp = "/tmp/" . "ictmp" . $$;

# Find/replace in tmp file, copy into place if found..
if (open CTL, "<$CONFIG_FILE" ) {
  if (open TMP, ">$tmp" ) {
    while (<CTL>) {
      $line = $_;
      if ($set == 0) {
        if (/$possibles_pattern/) {
          chop;
          $possibles_line = $_;
        }
        elsif (/$pattern/) {
          my $valid = 1;
          if ($possibles_line ne "") {
            $valid = 0;
            @poss = split /:/, $possibles_line;
            $poss = $poss[1];
            @possibles = split /\|/, $poss;

            my $tot= $#possibles;
            for (my $i = 0; $i <= $tot; $i++) {
              my $poss = $possibles[$i];
              # Trim whitespace..
              $poss =~ s/\s*$//gm ;
              $poss =~ s/^\s*//gm ;
              if ($CONFIG_VALUE eq $poss) {
                $valid = 1;
                last;
              }
            }
          }
          if ($valid == 1) {
            $line = $CONFIG_NAME . "=" . $CONFIG_VALUE . "\n";
            $set = 1;
          }
          $possibles_line = "";
        }
      }
      print TMP $line;
    } # while
    close TMP;
  }
  close CTL;
  # Copy over original if setting made..
  if ($set == 1) {
    my @copycmd = ("cp", $tmp, $CONFIG_FILE);
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