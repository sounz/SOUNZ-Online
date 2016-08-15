#!/usr/bin/perl

#script to import resource data for SOUNZ

use strict;
use DBI;


#open our file

open(RESOURCES,"resources.tab") or die "Couldn't open resource file!";

my $dbh = DBI->connect ( "dbi:Pg:dbname=sounz_new", "sounz", "");
if ( !defined $dbh ) {
die "Cannot connect to database!\n";
} 

my $line;
while ($line=<RESOURCES>)
	{
	$line=~s/'/\\'/g;
	$line=~s/\r//g;
    $line=~s/\n//g;
	#look up our resource type.
	my ($author,$title,$copies,$publisher,$type,$catnumber,$for_sale,$cost,$MWcode,$resource_type,$library_avail,$alt_title,$collation,$phys_description,$contents_note,$general_note,$internal_note,$copyright,$series_title,$year_of_publication,$imprint,$duration,$contributors,$format,$dedication_note,$resource_info,$availability_info,$item_info,$other_info,$performers,$SOUNZ_license,$completed,$format_note,$ISBN,$ISMN,$ISRC,$ISSN)=split(/\t/,$line);

	my $sth = $dbh->prepare("SELECT resource_type_id FROM resource_types where resource_type_desc ilike '%$resource_type%'");
	$sth->execute;
	my ($resource_type_id)=$sth->fetchrow();
	if ($resource_type_id eq "")
	{
	print "COULD NOT MATCH: |$resource_type|\n";
	}
	
	$type=~s/\s*$//g;
	$type=~s/'/\\'/g;
    #print "CHECKING TYPE: $type\n";
	my $sth = $dbh->prepare("SELECT format_id FROM formats where format_desc ilike ?");
	$sth->execute("\%$type\%");
	my ($format_type_id)=$sth->fetchrow();
	if ($format_type_id eq "")
	{
	print "COULD NOT MATCH: |$type|\n";
	}
	else
	{
	#print "MATCHED: $type\n";
	}	
   

	my $debugStatement.="---------------------------------------------------------------------\n";
    $debugStatement.="INSERT INTO resources (resource_type_id,format_id,status_id,author_note,resource_title,resource_title_alt,series_title,publication_year,isbn,ismn,isrc,issn,imprint,copyright,collation,duration,dedication_note,publisher_note,content_note,general_note,internal_note,resource_code,mw_code,clonable,available_for_loan,available_for_hire,available_for_sale,item_cost,freight_code,created_at,updated_at,updated_by) VALUES($resource_type_id,$format_type_id,3,'$author','$title','$alt_title','$series_title','$year_of_publication','$ISBN','$ISMN','$ISRC','$ISSN','$imprint','$copyright','$collation','$duration','$dedication_note','$publisher','$contents_note','$general_note,$internal_note $format $contributors $performers','$catnumber','$MWcode','true','$library_avail','false','$for_sale',$cost,'0000','2007-08-07','2007-08-07',1000);";
   
    $debugStatement.="---------------------------------------------------------------------\n";
   
if ($duration eq "")
		{$duration='00:00:00';}

   if ($catnumber eq "")
		{$catnumber=0;}


	$year_of_publication=~s/\?//g;  
    $year_of_publication=~s/\D//g;  
	$cost=~s/\$//g;  
	
    if ($year_of_publication eq "")
	{
	$year_of_publication="0000";
	}

	if ($library_avail eq "")
	{
	$library_avail='false'
	}

	if ($for_sale eq "")
	{
	$for_sale='false'
	}

    if ($cost eq "")
	{$cost=0;}

	my $sth = $dbh->prepare( "INSERT INTO resources (resource_type_id,format_id,status_id,author_note,resource_title,resource_title_alt,series_title,publication_year,isbn,ismn,isrc,issn,imprint,copyright,collation,duration,dedication_note,publisher_note,content_note,general_note,internal_note,resource_code,mw_code,clonable,available_for_loan,available_for_hire,available_for_sale,item_cost,freight_code,created_at,updated_at,updated_by) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
if ( !defined $sth ) {die "$debugStatement\n\n Cannot prepare statement: $DBI::errstr\n";}

$sth->execute($resource_type_id,$format_type_id,3,$author,$title,$alt_title,$series_title,$year_of_publication,$ISBN,$ISMN,$ISRC,$ISSN,$imprint,$copyright,$collation,$duration,$dedication_note,$publisher,$contents_note,$general_note,"$internal_note $format $contributors $performers",$catnumber,$MWcode,'true',$library_avail,'false',$for_sale,$cost,'0000','2007-08-07','2007-08-07',1000) or die("$year_of_publication | $debugStatement\n\n");

	#print "$author:$title:$format:$item_info:$completed\n";
	}

close (RESOURCES);










