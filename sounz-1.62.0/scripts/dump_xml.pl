#!/usr/bin/perl

use strict;
use warnings;

use Switch;
use XML::LibXML;
use Data::Dumper;
use Carp;
use DBI;

my $dbh = DBI->connect('dbi:Pg:dbname=sounz', 'martyn') or croak;

my $dom = XML::LibXML::Document->new();
my $root = $dom->createElement('add');
$dom->setDocumentElement($root);

my $db_works = $dbh->prepare(q{
    SELECT
        w.work_id,
        w.work_title,
        w.work_description,
        w.intended_duration,
        w.applicable_for_youth,
        w.year_of_creation,
        w.difficulty,
        l.language_name AS language,
        sc.work_subcategory_desc,
        c.work_category_desc
    FROM
        works w
        INNER JOIN work_languages wl ON w.work_id=wl.work_id
        INNER JOIN languages l ON wl.language_id=l.language_id
        INNER JOIN work_categorizations wc ON w.work_id=wc.work_id
        INNER JOIN work_subcategories sc ON wc.work_subcategory_id=sc.work_subcategory_id
        INNER JOIN work_categories c ON sc.work_category_id=c.work_category_id
    ORDER BY
        w.work_id
}) or croak $dbh->errstr;

$db_works->execute() or croak $dbh->errstr;


my $work;
while ( my $row = $db_works->fetchrow_hashref() ) {
    $work ||= $row;

    if ( $row->{work_id} != $work->{work_id} ) {
        add($work);
        $work = $row;
    }
    $work->{category}{$row->{work_category_desc}}{$row->{work_subcategory_desc}}++;
}
add($work);

sub add {
    my $work = shift;

    switch ( $work->{difficulty} ) {
        case 1 { $work->{difficulty} = 'Easy' }
        case 2 { $work->{difficulty} = 'Intermediate' }
        case 3 { $work->{difficulty} = 'Difficult' }
        else   { die 'Unknown difficuly' }
    }
    switch ( $work->{intended_duration} ) {
        case undef            { $work->{intended_duration} = 'Unknown'   }
        case { $_[0] < 180  } { $work->{intended_duration} = '< 3 min'   }
        case { $_[0] < 300  } { $work->{intended_duration} = '3-5 min'   }
        case { $_[0] < 600  } { $work->{intended_duration} = '5-10 min'  }
        case { $_[0] < 1800 } { $work->{intended_duration} = '10-30 min' }
        else                  { $work->{intended_duration} = '> 30 min'  }
    }

    my $doc = $dom->createElement('doc');
    foreach my $field ( qw(work_id work_title work_description intended_duration difficulty year_of_creation language) ) {
        warn "Invalid field '$field'" unless exists $work->{$field};
        next unless defined $work->{$field};
        my $element = $dom->createElement('field');
        $element->setAttribute('name', $field);
        $element->appendChild($dom->createTextNode($work->{$field}));
        $doc->appendChild($element);
    }
    if ( $work->{applicable_for_youth} ) {
        my $element = $dom->createElement('field');
        $element->setAttribute('name', 'difficulty');
        $element->appendChild($dom->createTextNode('Suitable for Youth'));
        $doc->appendChild($element);
    }
    foreach my $category ( keys %{$work->{category}} ) {
        my $element = $dom->createElement('field');
        $element->setAttribute('name', 'category');
        $element->appendChild($dom->createTextNode($category));
        $doc->appendChild($element);
        foreach my $subcategory ( keys %{$work->{category}{$category}} ) {
            my $element = $dom->createElement('field');
            $element->setAttribute('name', 'category_' . $category);
            $element->appendChild($dom->createTextNode($subcategory));
            $doc->appendChild($element);
        }
    }

    $root->appendChild($doc);
}


print $dom->toString(1), "\n";
