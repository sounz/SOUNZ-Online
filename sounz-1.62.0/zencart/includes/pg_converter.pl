#!/usr/bin/perl

#open our database table defs file.
my $infile=shift;
open(INFILE,$infile);
while (my $line=<INFILE>)
	{
	if ($line=~/^define/)
		{
		$line=~/'(.*?)',.*?.'(.*?)'/;
		print "define('$1_SEQ','$2_$2_id_seq');\n";
		}
	}

#for each line, if it matches our pattern, pull in our fragments and write out a sequence definition

