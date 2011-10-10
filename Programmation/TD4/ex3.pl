#!/usr/bin/perl
use warnings;
use strict;

my (@noms, $nom, @pluriels, $pluriel) ;
my ($index, $noms) ;

open(INVAR, '<', "noms-invariables.txt")
    or die "Vous devez avoir un fichier contenant les noms invariables !\n" ;
my @invar = <INVAR> ; # is needed cause you can't grep files (or else use File::Grep)

print "Entrez autant de noms commun masculin singulier que vous le voulez
(Tappez \"X\" pour continuer) : \n" ;

while (1)
{
  chomp($nom = <STDIN>) ;
  last if ($nom eq "X") ;
  @noms = (@noms, $nom) ;
}


# définition des pluriels
while (($index, $nom) = each @noms){
    ($pluriel = $nom) ;
    ($pluriel = $nom . "s") if (!grep (/$nom\n/, @invar ));
    @pluriels = (@pluriels, $pluriel);

    print "\nLes flexions de \"" , $nom , "\" sont :\n" ;
    print "un ", $nom, ", des " , $pluriel , "\n" ;
}
