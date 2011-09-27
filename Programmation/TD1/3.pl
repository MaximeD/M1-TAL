#!/usr/bin/perl -w

use strict ;

print "Comment vous appelez -vous ?\n" ;
$prenom = <STDIN> ;
chomp( $prenom ) ;

print "bonjour $prenom\n\n" ;

print "Quel âge avez-vous ?\n" ;
    chomp($age=<STDIN>) ;

print "Vous avez $age ans\n\n" ;

print "bonne" , " journée " , $prenom , "\n" ;
