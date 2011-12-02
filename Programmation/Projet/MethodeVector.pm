package MethodeVector;

use warnings ;
use strict ;

use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

use Answer ;

sub txt2hash{
  my $corpus = $_[0] ;
  my %freq;

  open(TXT, '<:utf8', $corpus) ;
  while (<TXT>){
    $_ =~ /(?<mot>\S+)\t(?<freq>\S+)\t/ ;
    $freq{ $+{mot} } = $+{freq};
  }
  close(TXT) ;

  return \%freq ;
}

sub txt2hash_suffix {
  my $corpus = $_[0] ;
  my %freq;
  my %hash_corpus ;

  open(FREQ, '<:utf8', $corpus);
  for (my $n = 1 ; $n < $_[1] ; $n++) {
    while (<FREQ>) {
      $_ =~ /
	      (:?(:?\S+)\t(:?\S+))  # not match
	      (:?\t(?<gramm>\S+)\t(?<freq>\S+)){$n}
	    /gx ;
      $hash_corpus{ $+{gramm} } = $+{freq};
    }
  }

  close(FREQ);

  return \%hash_corpus ;
}



sub mots {
  my @textes = @{ $_[1] } ;
  my @freq_corpus ;

  my $textes_nbr = scalar(@textes) ;

  for (my $i=0 ; $i <$textes_nbr ; $i++)
    {
      my $file_freq = lc ("frequencies/" . $textes[$i]{fh} . "_freq") ;
      $freq_corpus[$i] = &txt2hash($file_freq) ;
    }

  my $fileHandle = $_[0] ;
  open(TXT, '<:utf8', $fileHandle);

  my $count_words;
  my %txt ;
  while (<TXT>) {
    chomp($_);                          # rm newlines
    my @mots = split(/\pP|\pS|\s/, $_); # extract words
    foreach my $mot(@mots) {
      if ($mot ne ""){
	$count_words++ ;
	$txt{ lc ($mot) }++ ;
      }
    }
  }

  Answer::vector(\%txt,$count_words,\@freq_corpus,\@textes,"mots");
 
}


sub suffixes {
  my $fileHandle = $_[0] ;
  my @textes = @{ $_[1] } ;
  my $n = $_[2] ;
  my $textes_nbr = scalar(@textes) ;
  my %txt ;
  my @freq_corpus ;

  for (my $i=0 ; $i <$textes_nbr ; $i++)
    {
      my $file_freq = lc ("frequencies/" . $textes[$i]{fh} . "_freq") ;
      $freq_corpus[$i] = &txt2hash_suffix($file_freq,$n) ;
    }

  # shouldn't we get 10 * 4 values ?
  # while ( my($k,$v) = each %{ $freq_corpus[1] }) {
  #     print $k . $v . "\n";   
  # }


  open(TXT, '<:utf8', $fileHandle);
  my $count_words = 0;
  while (<TXT>) {
    for (my $i = 1 ; $i < 5 ; $i++) {
      for my $word(split(/\pP|\pS|\s/, $_)){
	$txt{$+{last}}++ and $count_words++ if $word =~ (/(?<last>.{$i}$)/) ;
      }
    }
  }                         # works

  Answer::vector(\%txt,$count_words,\@freq_corpus,\@textes,"suffixes");

}



return 1 ;
