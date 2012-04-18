#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use locale;
binmode(STDIN,  'utf8');
binmode(STDOUT, 'utf8');
binmode(STDERR, 'utf8');

use XML::Parser;

use Data::Dumper;

my $file = "b.xml";

my $tag;

my $parser = XML::Parser->new();
$parser->setHandlers(Start => \&startElement,
		     End => \&endElement,
		     Char => \&characterData,
		    );

$parser->parsefile($file);

my (@persons, $person);
my (@organisations, $organisation);

sub startElement {
  my ($parser, $tag, %attrs ) = @_;

  if ($tag eq "personne") {
    $person = 1;
  }
  if ($tag eq "organisation") {
    $organisation = 1;
  }

}


sub endElement {
  my ($parser, $elt) = @_;
  if ($elt eq "personne") {
    undef $person;
  } elsif ($elt eq "organisation") {
    undef $organisation;
  }
}

sub characterData {
  my ($parser, $data ) = @_;

  $data =~ s!\n+!!g;

  push @persons, $data if defined $person;
  push @organisations, $data if defined $organisation;
}

print "Le fichier fait mention des personnes suivantes :\n";
print join("\n", @persons) . "\n";

print "\n";
print "Le fichier fait mention des organisations suivantes :\n";
print join("\n", @organisations) . "\n";
