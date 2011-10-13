#!/usr/bin/env perl

use Encode qw(encode decode);
use strict ;
use warnings ;
use utf8 ;

open(GRIMM, '<:encoding(utf8)', 'conteGrimm.txt') or die ;


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

print encode("utf8", "\nOn les trouve aux lignes ci-après :\n") ;
my @lines_of_grimm ;
my @words5 ;

my $i ;
for ($i = 0 ; $i < $#grimm ;$i++)
  {
    @lines_of_grimm = split (/[ \?\.,\-‒!:;\']/, $grimm[$i]) ;
    print encode("utf8", "l" . ($i+1) . ". ") ;
    @words5 = ();
    foreach (@lines_of_grimm)
      {
	if (length($_) == 5)
	  {
	    @words5 = (@words5, lc($_)) ;
	  }
      }
    print encode("utf8", join(", ", @words5)) ;
    print "\n" ;
  }

close(GRIMM) ;
