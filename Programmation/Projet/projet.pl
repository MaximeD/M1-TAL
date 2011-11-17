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
chomp (my $file = "README" ) ; #<STDIN>) ;
open(FILE, '<:utf8', $file) ;

# var depending upon languages :
my (%file, %french, %english) ;
my @textes = (
    {lang => "?", name => \%file, fh => "FILE", corpus => $file },
    {lang => "french", name => \%french, fh => "FRENCH", corpus => "corpus/belle-rose.txt" },
    {lang => "english", name => \%english, fh => "ENGLISH", corpus => "corpus/gottfried-en.txt" }
    );


my $textes_nbr = scalar(@textes);
for (my $i=0 ; $i <$textes_nbr ; $i++)
{
    print "$textes[$i]{name} \t $textes[$i]{fh} \t $textes[$i]{corpus}\n";
    $textes[$i]{name} = MethodeMots::poids("$textes[$i]{fh}", $textes[$i]{corpus});
}

#for (my $i=0 ; $i <$textes_nbr ; $i++)
#{
#    $total_$textes[$i]{name} = MethodeMots::calcul2(\%file, $textes[$i]{name});
#}




#%french = MethodeMots::poids("FRENCH", "corpus/belle-rose.txt");
#%english = MethodeMots::poids("ENGLISH", "corpus/gottfried-en.txt");
#%file = MethodeMots::poids("FILE", $file);
my $total_french = MethodeMots::calcul2(\%file, \%french);
my $total_english = MethodeMots::calcul2(\%file, \%english);

MethodeMots::answer($total_french, $total_english );
MethodeSuffixes::main;

print "Combinaison des résultats...\n"; # Is it supposed to take that long ?

print "La langue du texte est :\n"; # If this works, you win a free beer

close(FILE) ;
