package MethodeMots;

use utf8;
binmode(STDOUT, ":utf8");

sub calcul {
  my %hash_corpus ;
  my $freq_text = "frequencies/" . lc($_[1] . "_FREQ");

  open(FREQ, '<:utf8', $freq_text);
  while (<FREQ>) {
      $_ =~ /(?<word>\S+)\t(?<freq>\S+)/ ;
      $hash_corpus{ $+{word} } = $+{freq};
  }

  my $weight = 0 ;

  open(F, '<:utf8', "$_[0]");

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

1; # a perl module must return true value
