#!/usr/bin/env perl

use strict ;
use warnings ;

open (FR, '<', 'fr') ;
open (EN, '<', 'en') ;

my %fr2en ;

my @fr=<FR>;
my @en=<EN>;

my $i ;
for ($i = 0 ; $i < $#fr ; $i++)
  {
    chomp($fr[$i]);
    chomp($en[$i]);
    $fr2en{$fr[$i]} = $en[$i] ;
  }

print "Tappez votre phrase à traduire mot à mot en anglais :\n" ;
my $phrase = (<STDIN>) ;

my @phrase = split (" ", $phrase);

my @phrase_en ;

foreach my $mot(@phrase)
  {
    if (exists $fr2en{$mot})
      {
	@phrase_en = (@phrase_en, $fr2en{$mot}) ;
      }
    elsif (exists $fr2en{lc($mot)} and $mot ne lc($mot))
      {
	@phrase_en = (@phrase_en, ucfirst($fr2en{lc($mot)})) ;
      }
	else
	  {
	    my $inconnu = "\e[1;34m$mot\e[0m" ; # colors
	    @phrase_en = (@phrase_en, $inconnu);
	  }
  }

print "\nen anglais :\n" . join(" ", @phrase_en) . "\n";

