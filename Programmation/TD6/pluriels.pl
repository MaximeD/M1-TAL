#!/usr/bin/perl -w

use strict ;
use locale ;

my (@noms, $nom, $invar, @pluriels, $pluriel, $i) ;
my $line ;

$invar = "noms-invariables.txt" ;
open (INVAR, "<", $invar) ;
my @invar = <INVAR> ;

my %irregular = (
		 ail => 'aulx',
		 ciel => 'cieux',
		 oeil => 'yeux'
		);

print "Entrez autant de noms commun masculin singulier que vous le voulez
(Tappez \"X\" pour continuer) : \n" ;

while (1) # Beware !
{
    chomp($nom = <STDIN>) ;
    last if ($nom eq "X") ;
    @noms = (@noms, $nom) ;
}


# définition des pluriels
foreach $nom(@noms)
{
  if (grep (/$nom\n/, @invar )) {
    $pluriel = $nom ;
  }
  elsif (exists $irregular{$nom}) {
    $pluriel = $irregular{$nom} ;
  }
  else {
    $pluriel = $nom . "s" ;
  }
  @pluriels = (@pluriels, $pluriel);
}

for ($i=0 ; $i < @noms ; $i++)
  {
    print "\nLes flexions de \"" , $noms[$i] , "\" sont :\n" ;
    print "un ", $noms[$i], ", des " , $pluriels[$i] , "\n" ;
  }

