#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

# passes args to the prog
use Getopt::Std ;
my %opts ;
# accepts the following args :
getopts( "f:i", \%opts ) ;

# needed modules
use Calcul;
use MethodeMots;
use MethodeSuffixes;
use Answer ;
use MethodeVector ;

################
# Core program #
################

# list of languages
my @textes = (
    {total => my $total_french,  fh => "FRENCH",  corpus => "corpus/french.txt"  },
    {total => my $total_english, fh => "ENGLISH", corpus => "corpus/english.txt" },
    {total => my $total_german,  fh => "GERMAN",  corpus => "corpus/german.txt"  },
    {total => my $total_italian, fh => "ITALIAN", corpus => "corpus/italian.txt" },
    {total => my $total_dutch,   fh => "DUTCH",   corpus => "corpus/dutch.txt"   },
    );

# gets the number of texts
my $textes_nbr = scalar(@textes);

# how many gramms we are looking for
my $gramm_number = 4 ;

# by default no need to recompute frequencies
my $reinitialize = 0 ;

# If -i is called,
# then overwrites existing frequencies
if ($opts{"i"}) {
    for (my $i=0 ; $i <$textes_nbr ; $i++)
    {
	print "Calcul des fréquences de $textes[$i]{corpus}\n";
	Calcul::freq($textes[$i]{fh}, $textes[$i]{corpus});
    }
    $reinitialize = 1 ;
}

# checks if there are missing frequency files
for (my $i=0 ; $i <$textes_nbr ; $i++) {
    my $path = "frequencies/" . lc ($textes[$i]{fh} . "_freq") ;
    unless (-e $path)
    {
	print "Le fichier $path n'a pas été trouvé !\n\tCalcul des fréquences de $textes[$i]{corpus}...\n";
	Calcul::freq($textes[$i]{fh}, $textes[$i]{corpus});
	$reinitialize = 1 ;
    }
}

# freqs are computed, restart is needed
print "Les fréquences ont été calculées, vous pouvez relancer le programme\n" and exit if $reinitialize == 1 ;


####################################
# Comparison with file starts here #
####################################
my $file ;

# if the filename was defined using the -f switch : go on
if (exists $opts{ "f" }) {
  $file = $opts{"f"} ;
}

# else : prompts the user for the filename
else {
   print "Bonjour, quel est le nom du fichier à analyser ?\n" ;
   chomp ($file = <STDIN>) ;
}


# gets the weight of words in the file for each language
my %totaux_mots ;
for (my $i=0 ; $i <$textes_nbr ; $i++) {
    $totaux_mots{ "$textes[$i]{fh}" } = MethodeMots::calcul($file, $textes[$i]{fh}) ;
}

# compares and prints the highest weight
Answer::method_result("mots",\%totaux_mots);

# gets the weight of suffixes in the file for each language
my %totaux_suffixes ;
for (my $i=0 ; $i <$textes_nbr ; $i++) {
    $totaux_suffixes{ "$textes[$i]{fh}" } = MethodeSuffixes::calcul($file, $textes[$i]{fh},4);
}

# compares and prints the highest weight
Answer::method_result("suffixes",\%totaux_suffixes);

# combines results
Answer::compare(\%totaux_mots,\%totaux_suffixes);

# the fun and accurate part
print "\n##################################\n";
print "\tANALYSE VECTORIELLE\n" ;

# compares file vector with corpus vectors, prints the result
MethodeVector::mots($file,\@textes);

# same thing with suffixes
MethodeVector::suffixes($file,\@textes,4);

