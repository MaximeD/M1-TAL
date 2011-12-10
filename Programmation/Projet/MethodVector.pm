package MethodVector;

use warnings ;
use strict ;

use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

use Calcul ;

# computes dot product
sub dot_product {
  my @freq_corpus = @{ $_[0] } ;
  my %txt = %{ $_[1] } ;
  my @textes = @{ $_[2] } ;

  
  my %results ;
  # loops over each language
  for (my $i= 0 ; $i < @freq_corpus ; $i++) {
    my ($numerator, $norm_corpus, $norm_txt, $denominator, $cos) ;

    # loops over one corpus frequency
    while ( my ($k,$v) = each %{ $freq_corpus[$i] }) {
      # numerator of dot product equals sum of txt value times corpus value
      $numerator += $v * $txt{$k} if (exists $txt{$k} ) ;
      # norm of vector corpus equals sum of square values
      $norm_corpus += $v ** 2 ;
      # norm of text equals sum of square values
      $norm_txt += $txt{$k} ** 2 if (exists $txt{$k} ) ;
    }

    # checks if no word has been identified
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

  # gets highest value and returns it
  my $max_weight = (reverse sort {$results{$a} <=> $results{$b}} keys %results)[0] ;

    return (lc($max_weight), $results{ $max_weight }) ;
}

# acquires frequencies computed by Calcul module
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

# computes suffixes weight for each language
sub txt2hash_suffix {
  my $corpus = $_[0] ;
  my %freq;
  my %hash_corpus ;

  open(FREQ, '<:utf8', $corpus);

  while (<FREQ>) {
      # We get the first good match
      $_ =~ /
	  (:?\S+\t\S+)               # not match
	  (:?\t(?<gramm>\S+)\t(?<freq>\S+))
	/gx  ;
      $hash_corpus{ $+{gramm} } = $+{freq};
      # and now everything that follows
      while ($_ =~ /(:?\t(?<gramm>\S+)\t(?<freq>\S+))/g){
	  $hash_corpus{ $+{gramm} } = $+{freq};
      }
  }

  close(FREQ);

  return \%hash_corpus ;
}


# computes vectors for words
sub words {
  my @textes = @{ $_[1] } ;
  my @freq_corpus ;

  my $textes_nbr = scalar(@textes) ;

  # acquires computed vectors by Calcul module
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

  # sorts frequencies for file words
  my @sorted = sort { ( $txt{$b} <=> $txt{$a}) or ($a cmp $b) } keys %txt ;

  # gets the n most frequent
  my %hash;
  for (my $i = 0; $i < 10 ; $i++) {
    $hash{$sorted[$i]} = $txt{$sorted[$i]}/$count_words*100 ;
  }


  # computes dot product
  my ($max_weight, $max_weight_value) ;
  ($max_weight, $max_weight_value) = &dot_product(\@freq_corpus, \%txt, $_[1]);

  # gives answer
  print "La langue du texte d'après l'analyse vectorielle des mots est :\n" ;
  printf "\t" . $max_weight . " (%.2f%%)\n", $max_weight_value ; #$results{ $max_weight } ;

}

# computes the gramm for our text
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
    for (my $i = 0; $i < 10 ; $i++) {
	$txt{$sorted[$i]} = $gramm{$sorted[$i]}/$count*100 ;
    }
    close(TXT);
    return \%txt ;
  }


# computes vectors for words
sub suffixes {
  my $fileHandle = $_[0] ;
  my @textes = @{ $_[1] } ;
  my $n = $_[2] + 1 ;
  my $textes_nbr = scalar(@textes) ;
  my %txt ;
  my @freq_corpus ;

  # acquires suffixes from corpus frequency file
  for (my $i=0 ; $i <$textes_nbr ; $i++)
    {
      $freq_corpus[$i] = Calcul::txt2hash_suffix($textes[$i]{frequencies},$n) ;
    }

  # computes suffixes for text
  for (my $i = 1 ; $i < 5 ; $i++ ) {
      my %gramm ;
      %gramm  = %{ &get_gramms($fileHandle,$i) } ;
      while (my($k,$v) = each %gramm){
	  $txt{$k} =  $v;
      }
  }
 
  my ($max_weight, $max_weight_value) ;
  ($max_weight, $max_weight_value) = &dot_product(\@freq_corpus, \%txt, $_[1]);

  # gives answer
  print "La langue du texte d'après l'analyse vectorielle des suffixes est :\n" ;
  printf "\t" . $max_weight . " (%.2f%%)\n", $max_weight_value ; #$results{ $max_weight } ;

}

1 ; # a module must return a true value
