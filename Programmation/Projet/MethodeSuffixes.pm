package MethodeSuffixes;

use warnings ;
use strict ;

use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

sub calcul {
  my %hash_corpus ;
  my $freq_text = "frequencies/" . lc($_[1] . "_FREQ");

  open(FREQ, '<:utf8', $freq_text);
  open(F, '<:utf8', "$_[0]");
  my $weight = 0 ;


  for (my $n = 1 ; $n < $_[2] ; $n++) {

  while (<FREQ>) {
      $_ =~ /
	      (:?(:?\S+)\t(:?\S+))  # not match
	      (:?\t(?<gramm>\S+)\t(?<freq>\S+)){$n}
	    /gx ;
      $hash_corpus{ $+{gramm} } = $+{freq};
  }


  while (<F>) {
    my @mots = split(/\pP|\pS|\s/, $_); # extract words
    foreach my $mot(@mots) {
      $mot =~ /(?<terminaison>.{$n}$)/;
      if (defined $+{terminaison} && exists $hash_corpus{"$+{terminaison}"} ){
	$weight += $hash_corpus{"$+{terminaison}"} ;
      }
    }
  }
  }

  close(FREQ);
  close(F);
  return $weight;
}

1; # must return true value
