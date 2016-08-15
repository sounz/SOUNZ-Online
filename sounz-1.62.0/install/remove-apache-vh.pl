#!/usr/bin/perl
#
# Remove an Apache Virtual Host config for SOUNZ
# This script is called from shell script 'remove-apache-vh.sh
# and is used to remove Virtual Host entries from the older apache
# configs where the VH is defined inside 'httpd.conf'. The shell caller
# script is used to set up the environment for this script.
#
# NOTE: This script depends on the Virtual Host being formatted with
# the ServerName directive directly following the <VirtualHost> tag,
# which is always the case for Axyl-inserted VirtualHost entries. If
# you change this, then expect it to fail safely - ie. nothing will
# be removed from the apache config.
#
#  Parameter 1 - the path to the current apache config file
#  Parameter 2 - the path to the new config file to create
#  Parameter 3 - the virtual host ServerName string

$progname = "remove-apache-vh.pl";
$HTTPD_CONF=$ARGV[0];
$HTTPD_NEW=$ARGV[1];
$VSERVERNAME=$ARGV[2];
if ("$HTTPD_CONF" eq "" || "$HTTPD_NEW" eq "" || "$VSERVERNAME" eq "") {
  exit 1;
}
if ( open CONF, "<$HTTPD_CONF" ) {
  $finished = 0;
  if ( open NEWCONF, ">$HTTPD_NEW" ) {
    $gotvh = 0;
    $finished = 0;
    $vhline = "";
    while (<CONF>) {
      $line = $_;
      if ($finished eq 1) {
        print NEWCONF $line;
      }
      else {
        if ($gotvh eq 1) {
          if (/.*?\<\/VirtualHost\>.*?/) {
            $finished = 1;
          }
        }
        else {
          if ("$vhline" eq "") {
            if (/.*?\<VirtualHost.*?/) {
              $vhline = $line;
            }
            else {
              print NEWCONF $line;
            }
          }
          else {
            if (/.*?ServerName $VSERVERNAME.*?/) {
              $gotvh = 1;
            }
            else {
              print NEWCONF $vhline;
              print NEWCONF $line;
              $vhline = "";
            }
          }
        }
      } # not finished
    } # while
    close NEWCONF;
    close CONF;
  }
  else {
    print "$progname: failed to open $HTTPD_NEW\n";
  }
  if ($finished eq 0) {
    unlink $HTTPD_NEW;
  }
}
else {
  print "$progname: failed to open $HTTPD_CONF\n";
}