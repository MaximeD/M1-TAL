#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use locale;
use v5.10;
binmode(STDIN,  'utf8');
binmode(STDOUT, 'utf8');
binmode(STDERR, 'utf8');

use XML::LibXML;
use Data::Dumper;
# the file to parse
my $file = "ttlnorm.xml";

# create the parser
my $parser = XML::LibXML->new();
my $tree = $parser->parse_file($file);
my $root = $tree->getDocumentElement;

# get a list of interesting nodes
my @w = $root->getElementsByTagName('w');

# create a list to store nouns
# and a second formatted like 'lemma_Cat'
my @word_list;
my @lemma_cat;

foreach my $word (@w) {
  if ($word->getAttribute('ana') =~ /^N/) {
    push @word_list, $word->getFirstChild->getData;
  }
  push @lemma_cat, $word->getAttribute('lemma') . "_" . $word->getAttribute('ana');
}

say "Afficher la liste des noms ?";
say join(", ", @word_list) if <STDIN> =~ /^(o|y)/;

say "\nAfficher les lemmes et leurs catégories ?";
say join(", ", @lemma_cat) if <STDIN> =~ /^(o|y)/;

say "\nExtraire l'annotation syntaxique ?";
if (<STDIN> =~ /^(o|y)/) {

  # get the last element of the list
  # to print closing tag when encountered
  my $last_child = pop @{ $root->getElementsByTagName('s') };

  foreach my $seg($root->getElementsByTagName('s')) {
    # retreive the actual tag
    my $actual_tag;

    # loop on every children
    foreach my $tag ($seg->childNodes()) {

      if ($tag->hasAttributes() && defined $tag->getAttribute('chunk')) {
	# get the content of 'chunk' attribute and format it
	my $syntax = $tag->getAttribute('chunk') ;
	$syntax = uc( substr($syntax, 0, 2) ) ;

	# check if it is the first time we meet him
	if (!defined $actual_tag) {
	  $actual_tag = $syntax;
	  print "<" . $syntax . ">" ;
	}
	# compare the current tag with the previous
	else {
	  if ($syntax ne $actual_tag) {
	    print "</" . $actual_tag . ">" ;
	    print "<" . $syntax . ">" ;
	    $actual_tag = $syntax;
	  }
	}
	print " " .$tag->getFirstChild->getData;

      }
      elsif (defined $tag->getFirstChild) {
	print $tag->getFirstChild->getData . " ";
      }
    }
    # print closing tag when meeting the last element
    print "</" . $actual_tag . ">" if $last_child;
  }
}

