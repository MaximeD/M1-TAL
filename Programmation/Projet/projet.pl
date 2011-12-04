#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

use Getopt::Std ;
my %opts ;
getopts( "f:i", \%opts ) ; # use -f to pass filename as argument

use Calcul;
use MethodeMots;
use MethodeSuffixes;
use Answer ;
use MethodeVector ;

################
# Core program #
################

# This program should be able to recognize
# the langage of the input.
# It's able to recognize~:
# Allemand, Anglais, Français, Italien et Néerlandais


my @textes = (
    {total => my $total_french,  fh => "FRENCH",  corpus => "corpus/french.txt"  },
    {total => my $total_english, fh => "ENGLISH", corpus => "corpus/english.txt" },
    {total => my $total_german,  fh => "GERMAN",  corpus => "corpus/german.txt"  },
    {total => my $total_italian, fh => "ITALIAN", corpus => "corpus/italian.txt" },
    {total => my $total_dutch,   fh => "DUTCH",   corpus => "corpus/dutch.txt"   },
    );

my $textes_nbr = scalar(@textes);

# If -i is called,
# then overwrite existing frequencies
# else, check if there are missing frequency files
my $reinitialize = 0 ;
if ($opts{"i"}) {
    for (my $i=0 ; $i <$textes_nbr ; $i++)
    {
	print "Calcul des fréquences de $textes[$i]{corpus}\n";
	Calcul::freq($textes[$i]{fh}, $textes[$i]{corpus});
    }
    $reinitialize = 1 ;
}


for (my $i=0 ; $i <$textes_nbr ; $i++) {
    my $path = "frequencies/" . lc ($textes[$i]{fh} . "_freq") ;
    unless (-e $path)
    {
	print "Le fichier $path n'a pas été trouvé !\n\tCalcul des fréquences de $textes[$i]{corpus}...\n";
	Calcul::freq($textes[$i]{fh}, $textes[$i]{corpus});
	$reinitialize = 1 ;
    }
}

print "Les fréquences ont été calculées, vous pouvez relancer le programme\n" and exit if $reinitialize == 1 ;



my $file ;
if (exists $opts{ "f" }) {                  # if the filename was defined using the -f switch : go on
  $file = $opts{"f"} ;
}
else {                                      # else : prompt the user for the filename
   print "Bonjour, quel est le nom du fichier à analyser ?\n" ;
   chomp ($file = <STDIN>) ;
}

open(FILE, '<:utf8', $file) ;


# my %totaux_mots ;
# for (my $i=0 ; $i <$textes_nbr ; $i++)
# {
#     $totaux_mots{ "$textes[$i]{fh}" } = MethodeMots::calcul($file, $textes[$i]{fh}) ;
# }

# Answer::method_result("mots",\%totaux_mots);


# my %totaux_suffixes ;
# for (my $i=0 ; $i <$textes_nbr ; $i++)
# {
#     $totaux_suffixes{ "$textes[$i]{fh}" } = MethodeSuffixes::calcul($file, $textes[$i]{fh},4);
# }

# Answer::method_result("suffixes",\%totaux_suffixes);


# print "Combinaison des résultats...\n"; # Is it supposed to take that long ?

# Answer::compare(\%totaux_mots,\%totaux_suffixes);

print "\n##################################\n";
print "\tANALYSE VECTORIELLE\n" ; 
MethodeVector::mots($file,\@textes);
MethodeVector::suffixes($file,\@textes,4);


close(FILE) ;
