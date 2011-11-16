#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDOUT, ":utf8");

use MethodeMots;
use MethodeSuffixes;

################
# Core program #
################

# This program should be able to recognize
# the langage of the input.
# It's able to recognize~:
# Allemand, Anglais, Français, Italien et Néerlandais

print "Bonjour, quel est le nom du fichier à analyser ?\n" ;
chomp (my $file = <STDIN>) ;
open(FILE, '<:utf8', $file) ;

MethodeMots::poids("FRENCH", "corpus/belle-rose.txt");
MethodeMots::poids("FILE", $file);
MethodeMots::answer;
MethodeSuffixes::main;

print "Combinaison des résultats...\n"; # Is it supposed to take that long ?

print "La langue du texte est :\n"; # If this works, you win a free beer

close(FILE) ;
