package MethodStandard;

use warnings ;
use strict ;

use Calcul;

use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

# computes word weight for each language
sub words {
  my %hash_corpus ;

  # acquire frequencies in file corpus
  %hash_corpus = %{ Calcul::txt2hash($_[1]) };

  my $weight = 0 ;

  open(F, '<:utf8', "$_[0]");

  # if a word in file has a weight in the corpus, adds it
  while (<F>) {
    my @mots = split(/\pP|\pS|\s/, $_); # extract words
    foreach my $mot(@mots) {
      if (exists $hash_corpus{"$mot"}){
	$weight += $hash_corpus{"$mot"} ;
      }
    }
  }

  close(F);
  return $weight;
}

# computes suffixes weight for each language
sub suffixes {
  my %hash_corpus ;
  my $weight = 0 ;

  %hash_corpus = %{ Calcul::txt2hash_suffix($_[1]) } ;
  
   open(F, '<:utf8', "$_[0]");

  # if a suffix in file has a weight in the corpus, adds it
  while (<F>) {
    my @words = split(/\pP|\pS|\s/, $_); # extract words
    foreach my $word(@words) {
	for (my $n = 1 ; $n <= $_[2] ; $n++) {
	    my $tail = substr $word, -$n ;
	    $weight += $hash_corpus{$tail} if (length($tail) == $n && exists $hash_corpus{$tail}); # avoid extra matches when word is shorter than gramm
	}
    }
  }
  close(F);
  return $weight;
}

1; # a perl module must return true value
