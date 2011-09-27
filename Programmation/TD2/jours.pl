#!/usr/bin/perl -w

use strict ;

my @jours = ( "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche" ) ;
my @days = ( "monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday" ) ;
my @tage = ( "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag" ) ;

my $total = @jours ;
my $order ;
print "Il y a $total jours dans la semaine.\n" ;
print "Le dernier jour de la semaine est : $jours[-1]\n\n" ;

print "Affichage des traductions de \@jours en anglais et en allemand :\n" ;
foreach $order(0 .. $#jours){
    print "Le mot \"$jours[$order]\" se traduit par \"$days[$order]\" en anglais et par \"$tage[$order]\" en allemand\n" ;
}
