use strict ;
use locale ;

my $nom;
my $pluriel ;
print "Entrez un nom commun masculin singulier : " ;
$nom = <STDIN>;
chomp($nom) ;

$pluriel = $nom . "s" ;
print "Les flexions de \"" , $nom, "\" sont :\n" ;
print "un " , $nom, "\n" ;
print "des " , $pluriel , "\n" ;
