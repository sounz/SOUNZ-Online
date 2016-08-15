#!/usr/bin/perl

use strict;
use warnings;
use YAML::Syck;
use FindBin;
use Data::Dumper;

my $works = LoadFile($FindBin::Bin . '/../sounz/test/fixtures/works.yml');
my @subcategories = values %{LoadFile($FindBin::Bin . '/../sounz/test/fixtures/work_subcategories.yml')};
my $id = 0;
my %work_categorizations;
my %seen;

foreach my $work ( values %{$works} ) {
    for (1 .. int(rand()*1.5 + 1)) {
        $id++;
        my $subid = $subcategories[int(rand($#subcategories))]->{work_subcategory_id};
        next if ( $seen{$work->{work_id} . $subid}++ );
        $work_categorizations{'work_categorizations_' . $id} = {
            work_id => $work->{work_id},
            work_subcategory_id => $subid,
            work_categorization_id => $id,
        }
    }
}

DumpFile($FindBin::Bin . '/../sounz/test/fixtures/work_categorizations.yml', \%work_categorizations);
