#!/usr/bin/perl

use strict;
use warnings;
use YAML::Syck;
use FindBin;
use Data::Dumper;

my $languages = {
    'english' => {
        language_id => 1,
        language_name => 'English',
        char_encoding => 'en_NZ',
        is_default => 'T',
        display_order => 1,
    },
    'maori' => {
        language_id => 2,
        language_name => 'Maori',
        char_encoding => 'en_MI',
        is_default => 'F',
        display_order => 2,
    },
    'other' => {
        language_id => 3,
        language_name => 'Other',
        char_encoding => 'en_OT',
        is_default => 'F',
        display_order => 3,
    },
};
my $works = LoadFile($FindBin::Bin . '/../sounz/test/fixtures/works.yml');
my $id = 0;
my %languages;
my %work_languages;

foreach my $work ( values %{$works} ) {
    $id++;
    $work_languages{'work_languages_' . $id} = {
        work_id => $work->{work_id},
        language_id => int(rand(3) + 1),
    };
}

DumpFile($FindBin::Bin . '/../sounz/test/fixtures/languages.yml', $languages);
DumpFile($FindBin::Bin . '/../sounz/test/fixtures/work_languages.yml', \%work_languages);

