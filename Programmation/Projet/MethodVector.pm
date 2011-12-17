package MethodVector;

use warnings ;
use strict ;

use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

use Calcul ;

# compute dot product
sub dot_product {
  my @freq_corpus = @{ $_[0] } ;
  my %txt = %{ $_[1] } ;
  my @textes = @{ $_[2] } ;

  
  my %results ;
  # loop over each language
  for (my $i= 0 ; $i < @freq_corpus ; $i++) {
    my ($numerator, $norm_corpus, $norm_txt, $denominator, $cos) ;

    # loop over one corpus frequency
    while ( my ($k,$v) = each %{ $freq_corpus[$i] }) {
      # numerator of dot product equals sum of txt value times corpus value
      $numerator += $v * $txt{$k} if (exists $txt{$k} ) ;
      # norm of vector corpus equals sum of square values
      $norm_corpus += $v ** 2 ;
      # norm of vector text equals sum of square values
      $norm_txt += $txt{$k} ** 2 if (exists $txt{$k} ) ;
    }

    # check if no word has been identified
    if (defined $norm_txt){
      # denominator equals square root of corpus norm times square root of texte norm
      $denominator = ($norm_corpus ** (1/2)) * ($norm_txt ** (1/2)) ;
      # cosinus is the fraction of descripted above
      $cos = $numerator / $denominator ;
      # convert in percentages
      $results{$textes[$i]{language}} = $cos * 100;
    }
    # if not found, percentage equals zero
    else {
      $results{$textes[$i]{language}} = 0;
    }
  }

  # get highest value and return it
  my $max_weight = (reverse sort {$results{$a} <=> $results{$b}} keys %results)[0] ;

  return (lc($max_weight), $results{ $max_weight }) ;
}

# compute vectors for words
sub words {
  my @textes = @{ $_[1] } ;
  my @freq_corpus ;

  my $textes_nbr = scalar(@textes) ;

  # acquire vectors computed by Calcul module
  for (my $i=0 ; $i <$textes_nbr ; $i++)
    {
      $freq_corpus[$i] = Calcul::txt2hash($textes[$i]{frequencies}) ;
    }

  # computes the word vector for our text
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

  # sort frequencies for file words
  my @sorted = sort { ( $txt{$b} <=> $txt{$a}) or ($a cmp $b) } keys %txt ;

  # get the n most frequent
  my %hash;
  for (my $i = 0; $i < $main::max_num ; $i++) {
    $hash{$sorted[$i]} = $txt{$sorted[$i]}/$count_words*100 if (exists $sorted[$i]);
  }


  # compute dot product
  my ($max_weight, $max_weight_value) ;
  ($max_weight, $max_weight_value) = &dot_product(\@freq_corpus, \%txt, $_[1]);

  # give answer
  print "According to the word analysis, the file is in...\n" ;
  printf "\t" . $max_weight . " (%.2f%%)\n" , $max_weight_value ;

}

# compute the gramm for our text
sub get_gramms {
    my $fileHandle = $_[0];
    open(TXT, '<:utf8', $fileHandle);
    my $count = 0 ;
    my %txt ;
    my %gramm ;
    my $n = $_[1] ;

    while (<TXT>) {
	for my $word(split(/\pP|\pS|\s/, $_)){
	    my $tail = substr $word, -$n ;
	    $gramm{$tail}++ and $count++ if (length($tail) == $n);
	}
    }

    my @sorted ;
    @sorted = sort { ( $gramm{$b} <=> $gramm{$a}) or ($a cmp $b) } keys %gramm ;
    for (my $i = 0; $i < $main::max_num ; $i++) {
	$txt{$sorted[$i]} = $gramm{$sorted[$i]}/$count*100 if (exists $sorted[$i]);
    }
    close(TXT);
    return \%txt ;
}


# compute vectors for suffixes
sub suffixes {
  my $fileHandle = $_[0] ;
  my @textes = @{ $_[1] } ;
  my $textes_nbr = scalar(@textes) ;
  my %txt ;
  my @freq_corpus ;

  # acquire suffixes from corpus frequency file
  for (my $i=0 ; $i <$textes_nbr ; $i++)
    {
      $freq_corpus[$i] = Calcul::txt2hash_suffix($textes[$i]{frequencies}) ;
    }

  # compute suffixes for text
  for (my $i = 1 ; $i <= $main::gramm_number ; $i++ ) {
      my %gramm ;
      %gramm  = %{ &get_gramms($fileHandle,$i) } ;
      while (my($k,$v) = each %gramm){
	  $txt{$k} =  $v;
      }
  }
 
  my ($max_weight, $max_weight_value) ;
  ($max_weight, $max_weight_value) = &dot_product(\@freq_corpus, \%txt, $_[1]);

  # give answer
  print "According to the suffix analysis, the file is in...\n" ;
  printf "\t" . $max_weight . " (%.2f%%)\n", $max_weight_value ;

}

1 ; # a module must return a true value
