#!/usr/bin/perl

use strict;
use warnings;
use YAML::Syck;
use FindBin;

my ($type, $concepts, $category);
my $work_categories_id = 0;
my %work_categories;
my $work_subcategories_id = 0;
my %work_subcategories;

load_data();

foreach my $wc ( keys %{$category} ) {
    $work_categories_id++;
    $work_categories{'work_category_' . $work_categories_id} = {
        work_category_id     => $work_categories_id,
        display_order        => $work_categories_id,
        work_category_abbrev => $wc,
        work_category_desc   => $wc,
    };
    foreach my $sc ( @{$category->{$wc}} ) {
        $work_subcategories_id++;
        $work_subcategories{'work_subcategory_' . $work_subcategories_id} = {
            work_subcategory_id     => $work_subcategories_id,
            work_category_id        => $work_categories_id,
            display_order           => $work_subcategories_id,
            work_subcategory_abbrev => $sc,
            work_subcategory_desc   => $sc,
        };
    }
}

DumpFile($FindBin::Bin . '/../sounz/test/fixtures/work_categories.yml', \%work_categories);
DumpFile($FindBin::Bin . '/../sounz/test/fixtures/work_subcategories.yml', \%work_subcategories);


sub load_data { # {{{
    $type = [
        'Recordings',
        'Sheet Music',
        'Digital Scores',
        'Other',
    ];
    $concepts = {
        Generes => [
            'Ambient',
            'Band Music',
            'Baroque',
            'Blues',
            'Christian and Gospel',
            'Dance',
            'Classical',
            'Folk and Acoustic',
            'Jazz',
            'Rock',
            'Rap and Hip-Hop',
            'Soul',
            'Vocal',
        ],
        Influences => [],
        Themes => [],
    };
    $category = {
        Orchestra => [
            'Full orchestra',
            'Chamber orchestra',
            'Full orchestra with soloist',
            'Chamber orchestra with soloist',
            'Full orchestra with multiple soloists',
            'Chamber orchestra with multiple soloists',
            'Orchestra using one section',
            'Concert Band or Symphonic Band',
            'String orchestra with or without soloist/s',
        ],
        Keyboard => [
            'Piano',
            'Organ (Pipe)',
            'Harpsichord, Clavichord etc.',
            'Electronic organ',
            'Miscellaneous keyboard - accordion',
            'Piano - 3 or more hands',
            'Keyboard - reduced scores for other ensembles',
            'Keyboard orchestra or ensemble',
            'Carillon',
        ],
        'Strings - Bowed' => [
            'Solo Violin - solo or with keyboard',
            'Viola - solo or with keyboard',
            'Cello - solo or with keyboard',
            'Double bass - solo or with keyboard',
            'Misc. bowed strings - viol, keyed fiddle',
            'String Duos',
            'String Trios',
            'String Quartets (without piano/keyboard)',
            'String ensembles (to nonet)',
        ],
        'Strings - Plectral' => [
            'Guitar - solo or with keyboard',
            'Harp - solo or with keyboard',
            'Misc. plectral strings - mandolin, ukulele, elec. guitar',
            'lectral string duos',
            'Plectral string trios',
            'Plectral String Quartets',
            'Plectral String Ensembles - up to nonets',
            'Plectral String Ensemble',
        ],
        Wind => [
            'Flute and piccolo - solo or with keyboard',
            'Oboe/Cor Anglais - solo or with keyboard',
            'Clarinet - solo or with keyboard',
            'Bassoon - solo or with keyboard',
            'Saxophone - solo or with keyboard',
            'Miscellaneous wind - recorder, ocarina, bagpipes',
            'Wind duos',
            'Wind trios',
            'Wind quartets',
            'Wind ensembles',
            'Wind ensembles (10 plus) or Wind Band',
        ],
        Brass => [
            'Trumpet - solo or with keyboard',
            'Horn - solo or with keyboard',
            'Trombone - solo or with keyboard',
            'Tuba - solo or with keyboard',
            'Miscellaneous Brass',
            'Brass Trios',
            'Brass ensembles (5-9 players)',
            'Brass Band or ensemble (10 plus)',
            'Military Band',
        ],
        Percussion => [
            'Percussionist - solo or with keyboard',
            'Percussion 2-4 players',
            'Percussion 5-9 players',
            'Percussion Ensemble (10 plus)',
            'Percussion ensemble - unspecified size',
        ],
        Chamber => [
            'Mixed chamber duos (not piano/keyboard)',
            'Mixed Chamber Trios (with keyboard)',
            'Mixed Chamber Trios (without keyboard)',
            'Mixed chamber quartets (with keyboard)',
            'Mixed chamber quartets (without keyboard)',
            'Mixed Chamber Quintet (with keyboard)',
            'Mixed chamber quintets (without keyboard)',
            'Mixed Chamber Sextets',
            'Mixed Chamber Septets',
            'Mixed Chamber Octets',
            'Mixed Chamber ensembles (10 plus)',
            'Mixed chamber ensemble - unspecified size',
        ],
        'Electro-acoustic' => [
            'Electro-acoustic, tape or multi-channel',
            'Computer Music and Synthesiser',
        ],
        'Vocal Solo' => [
            'Female voice - solo or with keyboard',
            'Female voice with other accomp. instr. (not piano)',
            'Male voice - solo or with keyboard',
            'Male voice with other accomp instr. (not piano)',
            'Unspecified voice- solo or with keyboard',
            'Unspecified voice with other accomp instr. (not piano)',
            'Soprano or Mezzo - solo or with keyboard',
            'Soprano and Mezzo with accomp. instr. (not piano)',
            'Contralto or alto - solo or with keyboard',
            'Contralto or alto with other accomp. instr. (not piano)',
            'Treble or Counter tenor - solo or with keyboard',
            'Treble or Counter tenor with other accomp. instr. (not piano)',
            'Tenor - solo or with keyboard',
            'Tenor with other accomp. instr. (not piano)',
            'Baritone or Bass - solo or with keyboard',
            'Baritone or Bass with other accomp. instr. (not piano)',
            'Female voice with instrumental ensemble',
            'Maori vocal',
            'Male Voice with Instrumental Ensemble',
            'Unspecified Voice with Instrumental Ensemble',
            'Vocal solo - other ethnicities',
            'Spoken word with accompanying instruments',
        ],
        'Vocal Ensemble' => [
            'Female duos - solo or with keyboard',
            'Male Vocal Duos - solo or with keyboard',
            'Mixed or unspecified vocal duos - solo or with keyboard',
            'Vocal trios/quartets - solo or with keyboard',
            'Vocal ensemble (5-8) - solo or with keyboard',
            'Vocal duos with accomp. instruments',
            'Vocal ensembles (3-8) with accomp. instruments',
            'Maori Vocal music (2-8 voices)',
        ],
        Choral => [
            'A Capella (+/- soloists)',
            'Choir with full orchestra (+/- soloists)',
            'Choir with chamber orchestra (+/- soloists)',
            'Choir with electronics/multi media (+/- soloists)',
            'Choir with keyboard (+/- soloists)',
            'Choir with various accomp (+/- soloists)',
            'Maori choral music',
            'Choral music - other ethnicities',
            'Womens choir +/- accomp. +/- soloist/s',
            'Male voice choir +/- accomp. +/- soloist/s',
            'Childrens choir',
        ],
        Sacred => [],
        'Stage, Screen, Exhibit' => [
            'Opera, operettas, singspiele',
            'Musical',
            'Music Theatre',
            'Ballet, Dance, Dance-drama',
            'Incidental music for theatre (Sound Design)',
            'Music for Films, TV, video or Radio',
            'Street Music or Theatre',
            'Sound sculptures/Installations',
        ],
        Experimental => [
            'Experimental music',
            'Improvised',
            'Noise',
            'Sound Art',
            'Laptop Art',
            'Time-based Art',
            'Digital Art',
            'Sound Manipulation',
            'Intermedia',
            'Music for found instruments',
            'Multimedia',
            'Visual Music',
        ],
    };
} # }}}
