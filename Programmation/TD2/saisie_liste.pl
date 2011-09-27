#!/usr/bin/perl -w

use strict ;
my $ligne ;
my @lignes ;

# Lecture une à une des lignes saisies
# Pour sortir de la boucle : ctrl -D
print "Please enter the terms you want to add to your list
and quit with CTRL+D\n";

while ($ligne = <STDIN>) {
# Enlever le caractère "fin de ligne"
    chomp($ligne);
# Placer la ligne dans le tableau
    push (@lignes, $ligne) ;
}

# Afficher le tableau
print "\@lignes : @lignes\n" ;

# Afficher le nombre d'éléments du tableau
print "That is " . ($#lignes + 1) . " elements\n";

# Afficher le dernier élément du tableau
print "And the last one of them is \"$lignes[-1]\"\n" ;
