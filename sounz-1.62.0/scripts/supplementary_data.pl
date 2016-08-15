#!/usr/bin/perl
use strict;
use DBI;

if ($ARGV[0] eq "")
   {
   die("No DB Name supplied. Invoke this script as follows: ./supplementary_data.pl <DBNAME> <DBUSER> <DBPASSWD>\n");
   }
my ($dbname,$dbuser,$dbpasswd)=@ARGV;



my $dbh = DBI->connect ( "dbi:Pg:dbname=$dbname", $dbuser, $dbpasswd);
if ( !defined $dbh ) {
die "Cannot connect to database!\n";
} 
print "-------------Tuhonohono-------------\n";

my $sth = $dbh->prepare( "insert into contactinfos (internal_note) values ('Contact info for tuhonono')");
if ( !defined $sth ) {die "Cannot prepare statement: $DBI::errstr\n";}
$sth->execute;
$sth = $dbh->prepare( "select lastval() from contactinfos_contactinfo_id_seq");
$sth->execute;
my @result=$sth->fetchrow();
my $contactinfo_id=$result[0];
print "Contactinfo ID: $contactinfo_id\n";

my $sth = $dbh->prepare( "insert into organisations (contactinfo_id,status_id,organisation_name,organisation_abbrev,internal_note) values ($contactinfo_id,1,'Tuhonohono','Tuhonohono','Internal note for Tuhonohono')");
$sth->execute;
$sth = $dbh->prepare( "select lastval() from organisations_organisation_id_seq");
$sth->execute;
my @result=$sth->fetchrow();
my $organisation_id=$result[0];
print "Organisation ID: $organisation_id\n";


$sth = $dbh->prepare( "insert into roles (role_type_id,organisation_id) values (23,$organisation_id)");
if ( !defined $sth ) {die "Cannot prepare statement: $DBI::errstr\n";}
$sth->execute;
$sth = $dbh->prepare( "select lastval() from roles_role_id_seq");
$sth->execute;
my @result=$sth->fetchrow();
my $role_id=$result[0];
print "Role ID: $role_id\n";

my $profile="A group of seven musicians, some of pakeha and some of Maori origin, form the nucleus of an ensemble formed to perform the works of Gillian Whitehead, one of the most important composers in Australasia. In 2004, she was invited to present a concert of her music in Jakarta, and formed Tuhonohono for the occasion. They have also performed at the Hei Tiki Gallery in Rotorua in 2005. \"Tuhonohono\" means to bring together, to weave, to join, to support, and hence in this interpretation: ‘weaving together the strands of Maori and European musical traditions.’

The performers in the ensemble include: Ramonda Te Maiharoa-Taleni: voice; Emma Sayers: piano; Ashley Brown: cello; Richard Nunns: taonga puoro/traditional instruments; Ingrid Culliford: flute and Ben Hoadley: bassoon'";

my $pull_quote="Tuhonohono - to bring together, to weave, to join.";

$sth = $dbh->prepare( "insert into contributors (status_id,contributor_agent_class,profile_other,pull_quote,internal_note) values (1,'O',?,?,'Established 2004')");
if ( !defined $sth ) {die "Cannot prepare statement: $DBI::errstr\n";}
$sth->execute($profile,$pull_quote);
$sth = $dbh->prepare( "select lastval() from contributors_contributor_id_seq");
$sth->execute;
my @result=$sth->fetchrow();
my $contributor_id=$result[0];
print "Contributor ID: $contributor_id\n";

$sth = $dbh->prepare( "insert into contributor_organisations (contributor_id,organisation_id) values ($contributor_id,$organisation_id)");
if ( !defined $sth ) {die "Cannot prepare statement: $DBI::errstr\n";}
$sth->execute;
$sth = $dbh->prepare( "select lastval() from contributor_organisations_id_seq");
$sth->execute;
my @result=$sth->fetchrow();
my $contributor_organisation_id=$result[0];
print "Contributor_Organisation ID: $contributor_organisation_id\n";

print "-------------Chamber Music NZ-------------\n";

my $sth = $dbh->prepare( "insert into contactinfos (internal_note,website_urls) values ('Contact info for Chamber Music NZ','http://www.chambermusic.co.nz')");
if ( !defined $sth ) {die "Cannot prepare statement: $DBI::errstr\n";}
$sth->execute;
$sth = $dbh->prepare( "select lastval() from contactinfos_contactinfo_id_seq");
$sth->execute;
my @result=$sth->fetchrow();
my $contactinfo_id=$result[0];
print "Contactinfo ID: $contactinfo_id\n";

my $sth = $dbh->prepare( "insert into organisations (contactinfo_id,status_id,organisation_name,organisation_abbrev,internal_note) values ($contactinfo_id,1,'Chamber Music New Zealand','Chamber Music NZ','Internal note for Chamber Music NZ')");
$sth->execute;
$sth = $dbh->prepare( "select lastval() from organisations_organisation_id_seq");
$sth->execute;
my @result=$sth->fetchrow();
my $organisation_id=$result[0];
print "Organisation ID: $organisation_id\n";


$sth = $dbh->prepare( "insert into roles (role_type_id,organisation_id) values (23,$organisation_id)");
if ( !defined $sth ) {die "Cannot prepare statement: $DBI::errstr\n";}
$sth->execute;
$sth = $dbh->prepare( "select lastval() from roles_role_id_seq");
$sth->execute;
my @result=$sth->fetchrow();
my $role_id=$result[0];
print "Role ID: $role_id\n";

my $profile="Chamber Music New Zealand is this country's largest presenter of top quality chamber music concerts throughout New Zealand. Their activities are divided into three strands: the Celebrity Season, which showcases top international artists; the Associate Societies programme, which focuses on New Zealand performers; and the New Zealand Community Trust Chamber Music Contest, which fosters the musical stars of the future.

Binding these strands together is a strong commitment to New Zealand music and musicians which has led to many specially commissioned works from New Zealand composers and the promotion of New Zealand performers.";

my $pull_quote="Chamber Music New Zealand is this country's largest presenter of top quality chamber music concerts throughout New Zealand.";

$sth = $dbh->prepare( "insert into contributors (status_id,contributor_agent_class,profile_other,pull_quote,internal_note) values (1,'O',?,?,'Established 1950')");
if ( !defined $sth ) {die "Cannot prepare statement: $DBI::errstr\n";}
$sth->execute($profile,$pull_quote);
$sth = $dbh->prepare( "select lastval() from contributors_contributor_id_seq");
$sth->execute;
my @result=$sth->fetchrow();
my $contributor_id=$result[0];
print "Contributor ID: $contributor_id\n";

$sth = $dbh->prepare( "insert into contributor_organisations (contributor_id,organisation_id) values ($contributor_id,$organisation_id)");
print "insert into contributor_organisations (contributor_id,organisation_id) values ($contributor_id,$organisation_id)\n";
if ( !defined $sth ) {die "Cannot prepare statement: $DBI::errstr\n";}
$sth->execute;
$sth = $dbh->prepare( "select lastval() from contributor_organisations_id_seq");
$sth->execute;
my @result=$sth->fetchrow();
my $contributor_organisation_id=$result[0];
print "Contributor_Organisation ID: $contributor_organisation_id\n";













#while ( my ($contributor_id,$legacy_code ) = $sth->fetchrow())
#	{
#	print "ID: $contributor_id,$legacy_code\n";
#	$contributorHash{$legacy_code}=$contributor_id;
#	} 

#supplementary data loading script for details its not worth writing an importer/yml for


