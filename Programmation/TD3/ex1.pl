#!/usr/bin/perl -w

use strict ;
use locale ;

my $nom ;
my $pluriel ;
my @invar ;
my $invar ;

print "Entrez un nom commun masculin singulier : " ;
chomp($nom = <STDIN>) ;

$pluriel = $nom . "s" ;

# invariables :
# ours, lynx, putois
@invar = ("ours", "lynx", "putois");

print "Les flexions de \"" , $nom , "\" sont :\n" ;

if (grep $_ eq $nom, @invar){
#if($nom eq "ours" || $nom eq "lynx" || $nom eq "putois"){
    print "un ", $nom, "\n";
    print "des " , $nom , "\n" ;
}

else {
    print "un " , $nom , "\n" ;
    print "des " , $pluriel , "\n" ;
}


