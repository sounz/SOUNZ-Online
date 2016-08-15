#!/usr/bin/perl
#Additional Category adder
use strict;
use DBI;


my $dbh = DBI->connect ( "dbi:Pg:dbname=sounz_new", "sounz", "s0unz");
if ( !defined $dbh ) {
die "Cannot connect to database!\n";
} 

open(ROLLBACK,">./rollback_category_patch.sql");

#this script will open the files in the additional categories directory, and create work_categorisation records to assign the works to their categories.

my %filenames=(
"Audience participation",132,
"Concerto",144,
"Dance ballet",179,
"Electroacoustic elements",137,
"Film and TV",180,
"For Educational use",131,
"Found instruments",141,
"Historic instruments",139,
"Improvised elements",135,
"incidental mus for theatre",178,
"live electronics",181,
"New Zealand Text",177,
"Orchestrations",183,
"piano quartet",148,
"Piano Trio",146,
"sacred",130,
"Sonata",187,
"Spoken word",182,
"Suitable for youth",176,
"Symphony",145,
"Taonga Puoro",143,
"Unspecified or variable",138,
"Wind quintet",147
);

my $sth=$dbh->prepare("SELECT nextval('work_categorizations_work_categorization_id_seq');");
$sth->execute;
$sth->close();
for my $filename (keys %filenames)
	{
	open (INFILE,"./additional_categories/$filename") or die "cannot open $filename";
	while (my $line=<INFILE>)
		{
		$line=~s/\n//;
		my ($composer,$title,$legacy_id)=split(/\t/,$line);
		
		#print "$filename: $title:$legacy_id\n";
		$sth = $dbh->prepare("SELECT work_id,work_title FROM works where legacy_4d_identity_code='$legacy_id'");
		$sth->execute;
		
		

		my ($work_id,$work_title)=$sth->fetchrow();
		#print "FOUND $work_id!\n";
		if ($work_id eq "")
			{
			#print "COULD NOT MATCH: $legacy_id\n";
			}
		else
			{
			print "$work_id $work_title\n";
			print "INSERT INTO work_categorizations (work_id,work_subcategory_id VALUES ($work_id,$filenames{$filename});";
			#$sth = $dbh->prepare("INSERT INTO work_categorizations (work_id,work_subcategory_id) VALUES ($work_id,$filenames{$filename});");
			#$sth->execute;
			
			#$sth=$dbh->prepare("SELECT currval('work_categorizations_work_categorization_id_seq');");
			#$sth->execute;
			#my ($currval)=$sth->fetchrow();

			#print "ROLLBACK: DELETE from work_categorizations WHERE work_categorization_id=$currval;\n";
			#print ROLLBACK "DELETE from work_categorizations WHERE work_categorization_id=$currval;\n";
			
			 
			

			}
		}
	
	close (INFILE);
	}
close (ROLLBACK);
