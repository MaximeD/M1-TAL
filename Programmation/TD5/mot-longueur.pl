#!/usr/bin/env perl

use locale ;
use strict ;
use warnings ;

open(GRIMM, '<', 'conteGrimm.txt') or die ;


# 1. Compter le nombre de mots de longueur 5 caractères dans le fichier.
my @grimm = <GRIMM> ;
my $grimm = join("", @grimm) ;

my $total;

while ($grimm =~ m/\b(\w{5})\b/gi)
{
    $total += 1 ;
}

print "Il y a $total mots de 5 lettres\n" ;

##############################################
# emplacement :

print "\nOn les trouve aux lignes ci-après :\n" ;
my @lines_of_grimm ;
my @words5 ;

my ($index, $value) ;
while (($index, $value) = each @grimm)
  {
    @lines_of_grimm = split (/[ \?\.,\-‒!:;\']/, $grimm[$index]) ;
    print "l" . ($index+1) . ". " ;
    foreach (@lines_of_grimm)
      {
	if (length($_) == 5)
	  {
	    # undef @words5 ;
	    # @words5 = (@words5, $_) ;
	    # print join(", ", @words5) ;
	    	    print "$_ ";
	  }
      }
    print "\n";
  }
