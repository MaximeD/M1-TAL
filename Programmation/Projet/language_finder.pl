#!/usr/bin/env perl

=pod

=head1 NAME

B<language_finder> - Recognize language of a file

=cut

use strict;
use warnings;
use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

# pass args to the prog
use Getopt::Std ;
my %opts ;
# accept the following args :
getopts( "f:ig:l:", \%opts ) ;

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
our ($gramm_number, $max_num) ;

if ($opts{"g"}) {
    $gramm_number = $opts{"g"}
}
else {
    $gramm_number = 4 ;
}

if ($opts{"l"}) {
    $max_num = $opts{"l"}
}
else {
    $max_num = 100 ;
}


# list of languages
my @texts = (
    {language => "czech"},
    {language => "dutch"},
    {language => "english"},
    {language => "esperanto"},
    {language => "finnish"},
    {language => "french"},
    {language => "greek"},
    {language => "german"},
    {language => "italian"},
    {language => "klingon"},
    {language => "portuguese"},
    {language => "spanish"},
    {language => "swedish"},
    );

# get the number of texts
my $texts_nbr = scalar(@texts);

# define path for corpus and frequencies file
for (my $i = 0 ; $i < $texts_nbr ; $i++){
    	$texts[$i]{corpus}      = "corpus/" . $texts[$i]{language} . ".txt" ;
	$texts[$i]{frequencies} = "frequencies/" . $texts[$i]{language} . "_freq" ;
}

# ?
my $variable_mystere = 0 ;

# If -i is called,
# then overwrite existing frequencies
# and check if there are missing frequency files
for (my $i=0 ; $i <$texts_nbr ; $i++) {
   if ($opts{"i"} or !-e $texts[$i]{frequencies}) {
	print "File $texts[$i]{frequencies} not found!\n" if (!-e $texts[$i]{frequencies}) ;
	print "\tComputing frequencies for $texts[$i]{corpus}...\n";
	Calcul::freq($texts[$i]{corpus},$texts[$i]{frequencies},$gramm_number);
	$variable_mystere = 1 ;
   }
   else {
       open(F, '<:utf8',  $texts[$i]{frequencies});
       my @f = <F>;
       close F;
       my $lines = @f;
       if ($lines != $max_num or $f[0] !~ /^(\S*?\t\S*?)(\t\S*?\t\S*?){$gramm_number}$/) {
	   print "File $texts[$i]{frequencies} does not contain the require amount of words\n" ;
	   print "\tComputing frequencies for $texts[$i]{corpus}...";
	   Calcul::freq($texts[$i]{corpus},$texts[$i]{frequencies},$gramm_number);
	   print "\n" ;
	   $variable_mystere = 1 ;
       }
   }
}

print "\n" if $variable_mystere == 1 ;

# wonder if the user just wanted to create the frequency files
if ($opts{"i"} and !exists $opts{"f"}){
    print "Would you like to analyze a text now?\n" ;
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
   print "Hello, which file would you like to analyze?\n" ;
   chomp ($file = <STDIN>) ;
}


print "##################################\n";
print "\tSTANDARD ANALYSIS" ;
print "\n##################################\n";

# get the weight of words in the file for each language
my %total_words ;
for (my $i=0 ; $i <$texts_nbr ; $i++) {
    $total_words{ "$texts[$i]{language}" } = MethodStandard::words($file, $texts[$i]{frequencies}) ;
}

# compare and print the highest weight
Answer::method_result("word",\%total_words);

# get the weight of suffixes in the file for each language
my %total_suffixes ;
for (my $i=0 ; $i <$texts_nbr ; $i++) {
    $total_suffixes{ "$texts[$i]{language}" } = MethodStandard::suffixes($file, $texts[$i]{frequencies});
}

# compare and print the highest weight
Answer::method_result("suffix",\%total_suffixes);

# combine results
Answer::compare(\%total_words,\%total_suffixes);

# the fun and accurate part
print "\n##################################\n";
print "\tVECTORIAL ANALYSIS" ;
print "\n##################################\n";

# compare file vector with corpus vectors, print the result
MethodVector::words($file,\@texts);

# same thing with suffixes
MethodVector::suffixes($file,\@texts,$gramm_number);


=pod

=head1 SYNOPSIS

B<language_finder> B<-f> text to analyze
B<-l> number of occurences to process
B<-g> highest suffix length to process
(B<-i> reinitialize)

=head1 DESCRIPTION

B<language_finder>
will recognize the original language
of a source file given by the user.
To do so,
it will compare the input text words with a corpus.
At the moment, it is able to recognize the following languages:
czech, english, finnish, german, italian, klingon, spanish,
dutch, esperanto, french, greek, portuguese and swedish.

Any other language can easily be added by putting
a text file written in this language
into the I<corpus> directory and by adding the relevant line
in the list of languages of this file.


=head1 OPTIONS

=over

=item B<-f> text to analyze

=item B<-l> <integer> number of occurences to process

=item B<-g> <integer> highest suffix length to process

=item B<-l> <integer> number of occurences to process

=item B<-i> reinitialize frequencie files

=back


=head1 DIRECTORIES

=over

=item I<corpus> contains a reference file per language.
This file is a text (likely a novel)
that will be used to get the frequency of words.

=item I<frequencies> frequencies computed will be transformed
into an array associating a word (or a "suffix") and it's frequency.
This is the files that will be overwritten with the B<-i> switch.

=back


=head1 AUTHORS

=over

=item DEMOLIN Maxime <maxime.demolin@etu.unistra.fr>

=item TALEB Chafik   <chafik.taleb@etu.unistra.fr>

=back


=cut
