#!/usr/bin/perl
use warnings;
use strict;

my (@noms, $nom, @pluriels, $pluriel, @invar, $invar, $i) ;

open(INVAR, '<', "noms-invariables.txt") or die "Vous devez avoir un fichier contenant les noms invariables !\n" ;
@invar = <INVAR> ;

print "Entrez autant de noms commun masculin singulier que vous le voulez
(Tappez \"X\" pour continuer) : \n" ;

while (1)
{
  chomp($nom = <STDIN>) ;
  last if ($nom eq "X") ;
  @noms = (@noms, $nom) ;
}


# définition des pluriels
foreach $nom(@noms)
  {
    ($pluriel = $nom) if (grep (/$nom\n/, @invar ));
    ($pluriel = $nom . "s") if (!grep (/$nom\n/, @invar ));
    @pluriels = (@pluriels, $pluriel);
  }


for ($i=0 ; $i < @noms ; $i++)
  {
    print "\nLes flexions de \"" , $noms[$i] , "\" sont :\n" ;
    print "un ", $noms[$i], ", des " , $pluriels[$i] , "\n" ;
  }
