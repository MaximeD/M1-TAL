#!/usr/bin/env perl

use strict ;
use locale ;
use warnings ;

my $nom ;
my $pluriel ;

print "Entrez un nom commun masculin singulier : " ;
chomp($nom = <STDIN>);

$pluriel = $nom . "s" ; # well, let's say that most of the time it works

print "Les flexions de $nom sont :
un $nom,
des $pluriel \n" ;
