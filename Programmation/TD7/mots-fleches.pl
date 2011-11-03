#!/usr/bin/env perl

use strict;
use warnings;

my $mot ;
my @possible ;

open(LEXIQUE, '<', "lexique.txt") ;

print "Veuillez entrer un mot à compléter:\n" ;
chomp($mot = <STDIN>) ;

if ($mot =~ /\./)
{
    chomp(@possible = grep(/^$mot$/, <LEXIQUE>)) ;
    
    if (@possible) # check if we have something to return ie. array not empty
    {
	print "Les possibilités sont les suivantes :\n\"" . join("\", \"", @possible) . "\"\n" ;
    }
    else
    {
	print "Aucun possibilité n'a été trouvée !\n";
    }
}
else
{
    print "Votre mot est déjà complet !\n";
    print "Veuillez remplacer les caractères inconnus par un point svp.\n" ;
}


close(LEXIQUE) ;

