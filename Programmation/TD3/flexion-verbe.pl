#!/usr/bin/perl -w
use strict ;

my ( $radical, $inf, $verb, $i ) ;
my @pronoms = ( "je", "tu", "il/elle", "nous", "vous", "ils/elles" ) ;
my @terminaisons_1 = ( "e", "es", "e", "ons", "ez", "ent" ) ;
my @terminaisons_2 = ( "is", "is", "it", "issons", "issez", "issent" ) ;

print "Entrez un verbe du 1er ou du 2eme groupe : " ;
chomp($verb=<STDIN>) ;
if ($verb =~ m/er$/){
    $inf = $verb ;
    $inf =~ s/er$//;
        
    print "Les formes du verbe \"$verb\" au présent de l'indicatif sont :\n" ;
    
    for ($i=0; $i<@pronoms; $i++)
    {
	print $pronoms[$i] . " " . $inf . $terminaisons_1[$i] . "\n" ;
    }
}
elsif ($verb =~ m/ir$/){
    $inf = $verb ;
    $inf =~ s/ir$//;
        
    print "Les formes du verbe \"$verb\" au présent de l'indicatif sont :\n" ;
    
    for ($i=0; $i<@pronoms; $i++)
    {
	print $pronoms[$i] . " " . $inf . $terminaisons_2[$i] . "\n" ;
    }
}

else{print "\"$verb\" n'est pas un verbe du premier ou du secpnd groupe !\n"}
