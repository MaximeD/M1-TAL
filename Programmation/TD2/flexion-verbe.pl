#!/usr/bin/perl -w
use strict ;

my ( $radical, $inf, $verb, $i ) ;
my @pronoms = ( "je", "tu", "il/elle", "nous", "vous", "ils/elles" ) ;
my @terminaisons = ( "e", "es", "e", "ons", "ez", "ent" ) ;

print "Entrez un verbe du 1er groupe : " ;
chomp($verb=<STDIN>) ;
if ($verb =~ m/er$/){
    $inf = $verb ;
    $inf =~ s/er$//;
    
    
    print "Les formes du verbe \" $verb \" au présent de l'indicatif sont :\n" ;
    
    for ($i=0; $i<@pronoms; $i++)
    {
	print $pronoms[$i] . " " . $inf . $terminaisons[$i] . "\n" ;
    }
}

else{print "Ceci n'est pas un verbe du premier groupe !\n"}
