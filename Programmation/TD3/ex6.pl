#!/usr/bin/perl

use strict ;
use locale ;

my $s = "Ceci est une phrase" ;
my (@tab, $tab) ;
my $total = 0 ;

# construit un tableau
@tab = split(/ /, $s) ;

# compte le nombre de mots
foreach (@tab)
{
    $total += 1 ;
}

print "La chaine contient $total mots\n" ;

# affiche le premier et le dernier mot dans l'ordre alphabétique
my $s_2 = lc($s) ;
my @tab_2 = split(/ /, $s_2) ;
my @sorted_tab = sort @tab_2 ;

print @sorted_tab . "\n";


