#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

# pass args to the prog
use Getopt::Std ;
my %opts ;
# accept the following args :
getopts( "f:in:", \%opts ) ;

# needed modules
use Calcul;
use MethodStandard ;
use MethodVector ;
use Answer ;

################
# Core program #
################

# global vars
# how many gramms we are looking for
our $gramm_number = 4 ; # if you want to change it, do it here
our $max_num = 50 ;

# list of languages
my @texts = (
    {language => "french"},
    {language => "english"},
    {language => "german"},
    {language => "italian"},
    {language => "dutch"}
    );

# get the number of texts
my $texts_nbr = scalar(@texts);

# define path for corpus and frequencies file
for (my $i = 0 ; $i < $texts_nbr ; $i++){
    	$texts[$i]{corpus}      = "corpus/" . $texts[$i]{language} . ".txt" ;
	$texts[$i]{frequencies} = "frequencies/" . $texts[$i]{language} . "_freq" ;
}

# If -i is called,
# then overwrite existing frequencies
# and check if there are missing frequency files
for (my $i=0 ; $i <$texts_nbr ; $i++) {
   if ($opts{"i"} or !-e $texts[$i]{frequencies} or exists $opts{"n"}) {
	print "Le fichier $texts[$i]{frequencies} n'a pas été trouvé !\n" if (!-e $texts[$i]{frequencies}) ;
	print "\tCalcul des fréquences de $texts[$i]{corpus}...\n";
	Calcul::freq($texts[$i]{corpus},$texts[$i]{frequencies},$gramm_number);
   }
}

# wonders if the user just wanted to create the frequency files
if ($opts{"i"} and !exists $opts{"f"}){
    print "Voulez-vous analyser un fichier maintenant ?\n" ;
    exit if (<STDIN> !~ /^o/i) ;
}


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
my %total_words ;
for (my $i=0 ; $i <$texts_nbr ; $i++) {
    $total_words{ "$texts[$i]{language}" } = MethodStandard::words($file, $texts[$i]{frequencies}) ;
}

# compares and prints the highest weight
Answer::method_result("mots",\%total_words);

# gets the weight of suffixes in the file for each language
my %total_suffixes ;
for (my $i=0 ; $i <$texts_nbr ; $i++) {
    $total_suffixes{ "$texts[$i]{language}" } = MethodStandard::suffixes($file, $texts[$i]{frequencies},$gramm_number);
}

# compares and prints the highest weight
Answer::method_result("suffixes",\%total_suffixes);

# combines results
Answer::compare(\%total_words,\%total_suffixes);

# the fun and accurate part
print "\n##################################\n";
print "\tANALYSE VECTORIELLE\n" ;

# compares file vector with corpus vectors, prints the result
MethodVector::words($file,\@texts);

# same thing with suffixes
MethodVector::suffixes($file,\@texts,$gramm_number);

