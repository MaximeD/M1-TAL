package MethodeMots;

use utf8;
binmode(STDOUT, ":utf8");

sub main {

###############################
# We want to download files ? #
###############################
#
# use LWP::Simple;
#
# sub dwn_file {
# my $url = 'http://www.gutenberg.org/cache/epub/17808/pg17808.txt';
# getstore($url, "corpus/belle-rose.txt");
# }


sub poids {
  my $count_words ;                     # total words in file
  my $fileHandle = $_[0];               # a way to pass a filehandle as an argument
  while (<$fileHandle>) {
    chomp($_); # rm newlines
    my @mots = split(/\pP|\pS|\s/, $_); # extract words
    foreach my $mot(@mots) {
      if ($mot ne ""){
	$count_words++ ;
	$freq{ lc ($mot) }++ ;
      }
    }
  }

  # sorting hash
  my @sorted = sort { ( $freq{$b} <=> $freq{$a}) or ($a cmp $b) } keys %freq ;

  # most frequent :
  print "Les dix mots les plus fréquents et leurs poids sont :\n";
  my $i ;
  for ($i = 0 ; $i < 10 ; $i++) {
    print "$sorted[$i] \t". $freq{$sorted[$i]}/$count_words*100 . "\n";
  }
}

# files to compare with :

# open(DUTCH, '<:utf8', "corpus/?") ;
# open(ENGLISH, '<:utf8', "corpus/?") ;
open(FRENCH, '<:utf8', "corpus/belle-rose.txt") ;
# open(GERMAN, '<:utf8', "corpus/?") ;
# open(ITALIAN, '<:utf8', "corpus/?") ;

# &poids(DUTCH) ;
# &poids(ENGLISH) ;
&poids(FRENCH) ;
# &poids(GERMAN) ;
# &poids(ITALIAN) ;

# close(DUTCH);
# close(ENGLISH);
close(FRENCH);
# close(GERMAN);
# close(ITALIAN) ;



############
# output ! #
############

print "La langue du texte d'après l'analyse des mots est :\n"

}

1; # must return true value
