#!/usr/bin/perl -w
use strict ;

my ( $radical, $inf, $verb, $i ) ;
my @terminaisons ;
my @pronoms = ( "je", "tu", "il/elle", "nous", "vous", "ils/elles" ) ;
my @terminaisons_1 = ( "e", "es", "e", "ons", "ez", "ent" ) ;
my @terminaisons_2 = ( "is", "is", "it", "issons", "issez", "issent" ) ;

sub Conjugate{
    print "Les formes du verbe \"$verb\" au présent de l'indicatif sont :\n" ;
    
    $inf = $verb ;
    $inf =~ s/.{2}$//;

    for ($i=0; $i<@pronoms; $i++)
    {
	print $pronoms[$i] . " " . $inf . $terminaisons[$i] . "\n" ;
    }
}

print "Entrez un verbe du 1er ou du 2eme groupe : " ;
chomp($verb=<STDIN>) ;

if ($verb =~ m/er$/){
    @terminaisons = @terminaisons_1 ;
    &Conjugate ;
}       
 
elsif ($verb =~ m/ir$/){
    @terminaisons = @terminaisons_2 ;
    &Conjugate ;
}

else{print "\"$verb\" n'est pas un verbe du premier ou du second groupe !\n"}
