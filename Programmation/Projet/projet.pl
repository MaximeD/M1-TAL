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
my ($total_file, $total_french, $total_english) ;

my @textes = (
    {                         hash => \%file,    fh => "FILE",    corpus => $file },
    {total => $total_french,  hash => \%french,  fh => "FRENCH",  corpus => "corpus/belle-rose.txt" },
    {total => $total_english, hash => \%english, fh => "ENGLISH", corpus => "corpus/gottfried-en.txt" }
    );


my $textes_nbr = scalar(@textes);
for (my $i=0 ; $i <$textes_nbr ; $i++)
{
    print "$textes[$i]{hash} \t $textes[$i]{fh} \t $textes[$i]{corpus}\n";
    $textes[$i]{hash} = MethodeMots::poids("$textes[$i]{fh}", $textes[$i]{corpus});
}

for (my $i=0 ; $i <$textes_nbr ; $i++)
{
  if (!$textes[$i]{total}) {                                             # there is no total for $file <STDIN>
    $textes[$i]{total} = MethodeMots::calcul2(\%file, $textes[$i]{hash});
  }
}




#%french = MethodeMots::poids("FRENCH", "corpus/belle-rose.txt");
#%file = MethodeMots::poids("FILE", $file);
#my $total_french = MethodeMots::calcul2(\%file, \%french);
#my $total_english = MethodeMots::calcul2(\%file, \%english);

MethodeMots::answer($total_french, $total_english );
MethodeSuffixes::main;

print "Combinaison des résultats...\n"; # Is it supposed to take that long ?

print "La langue du texte est :\n"; # If this works, you win a free beer

close(FILE) ;
