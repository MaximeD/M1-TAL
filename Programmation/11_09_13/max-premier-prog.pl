#!/usr/bin/perl -w

use strict ;
use locale ;

# variables you have to declare
# because of 'use strict'
my ($nom, $pluriel) ;

print "Entrez un nom commun masculin singulier : " ;
chomp($nom = <STDIN>);

$pluriel = $nom . "s" ; # well, let's say that most of the time it works

print "Les flexions de $nom sont :
un $nom,
des $pluriel \n" ;
