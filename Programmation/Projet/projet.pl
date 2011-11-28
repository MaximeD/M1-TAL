#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDOUT, ":utf8");

use Getopt::Std ;
my %opts ;
getopts( "f:", \%opts ) ; # use -f to pass filename as argument

use MethodeMots;
use MethodeSuffixes;

my $file ;
if (exists $opts{ "f" }) {                  # if the filename was defined using the -f switch : go on
  $file = $opts{"f"} ;
}
else {                                      # else : prompt the user for the filename
   print "Bonjour, quel est le nom du fichier à analyser ?\n" ;
   chomp ($file = <STDIN>) ;
}


# opening the file
open(FILE, '<:utf8', $file) or die "Impossible d'ouvrir $file\n" ;


# var depending upon languages :
my (%file, %french, %english) ;
my ($total_french, $total_english) ;

my @textes = (
    {                         hash => \%file,    fh => "FILE",    corpus => $file },
    {total => $total_french,  hash => \%french,  fh => "FRENCH",  corpus => "corpus/belle-rose.txt" },
    {total => $total_english, hash => \%english, fh => "ENGLISH", corpus => "corpus/en.txt" }
    );


my $textes_nbr = scalar(@textes);
for (my $i=0 ; $i <$textes_nbr ; $i++)
{
  if (exists $textes[$i]{total}) { 
   print "$textes[$i]{hash}  \t $textes[$i]{fh} \t $textes[$i]{corpus}\n";
    %{$textes[$i]{hash}} = MethodeMots::poids($textes[$i]{fh}, $textes[$i]{corpus})
  };
}

for (my $i=0 ; $i <$textes_nbr ; $i++)
{
  if (exists $textes[$i]{total}) {                                       # there is no total for $file <STDIN>
    $textes[$i]{total} = MethodeMots::calcul($textes[0]{corpus}, $textes[$i]{hash});
  }
}


MethodeMots::answer($textes[1]{total},$textes[2]{total});

for (my $i=0 ; $i <$textes_nbr ; $i++)
{
  if (exists $textes[$i]{total}) { 
   print "$textes[$i]{hash}  \t $textes[$i]{fh} \t $textes[$i]{corpus}\n";
    %{$textes[$i]{hash}} = MethodeSuffixes::poids($textes[$i]{fh}, $textes[$i]{corpus})
  };
}


#%french = MethodeMots::poids("FRENCH", "corpus/belle-rose.txt");
#%file = MethodeMots::poids("FILE", $file);
#my $total_french = MethodeMots::calcul2(\%file, \%french);
#my $total_english = MethodeMots::calcul2(\%file, \%english);

#MethodeMots::answer($total_french, $total_english );
#MethodeSuffixes::main;

print "Combinaison des résultats...\n"; # Is it supposed to take that long ?

print "La langue du texte est :\n"; # If this works, you win a free beer

close(FILE) ;
