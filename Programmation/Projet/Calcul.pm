package Calcul;

use warnings ;
use strict ;

use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

# computes suffixes weight
sub suffix_weight {
    my $gramm_number = $_[1] ; # How many gramms are we looking for ?
    my $k = $_[2] ;
    my %gramm ;
    my $count = 0 ;

    open(CORPUS, '<:utf8', $_[0]);
    while (<CORPUS>) {
      for my $word(split(/\pP|\pS|\s/, $_)){
	  my $tail = substr $word, -$gramm_number ;
	  $gramm{$tail}++ and $count++ if (length($tail) == $gramm_number);
      }
    }

    # sorting hash by descending value
    my @sorted = sort { ( $gramm{$b} <=> $gramm{$a}) or ($a cmp $b) } keys %gramm ;

    close(CORPUS);

    return ($sorted[$k], $gramm{$sorted[$k]} / $count * 100)  ;
}

# computes word frequencies
sub freq {
  my %freq ;
  my $count_words = 0 ;                   # total words in file / reinitialize
  my $corpus = $_[0];

  open(CORPUS, '<:utf8', $corpus);

  # creates hash of word frequencies
  while (<CORPUS>) {
    chomp($_);                          # rm newlines
    my @words = split(/\pP|\pS|\s/, $_); # extract words
    foreach my $word(@words) {
      if ($word ne ""){
	$count_words++ ;
	$freq{ lc ($word) }++ ;
      }
    }
  }
  close(CORPUS);

  # sorts hash
  my @sorted = sort { ( $freq{$b} <=> $freq{$a}) or ($a cmp $b) } keys %freq ;

  # most frequent :
  my %hash;

  # writes in the file
  open(OUTPUT, '>:utf8', $_[1] );

  for (my $i = 0; $i < $main::max_num ; $i++) {
    my @gramm = () ;
    $hash{$sorted[$i]} = $freq{$sorted[$i]}/$count_words*100 ;
    for (my $j = 1; $j < $_[2] ; $j++) {
	my @gramm_n = &suffix_weight($corpus,$j,$i) ;
	@gramm = (@gramm, @gramm_n);	
    }

    # saves values as percentages
    print OUTPUT $sorted[$i] . "\t" . $freq{$sorted[$i]}/$count_words*100 . "\t" . join("\t", @gramm) . "\n";
}
  close(OUTPUT);
}

# computes text frequencies
sub freq_txt {
    my $text ;
    my %hash_freq_text ;
    my $count_words ;

    open($_[0], '<:utf8', $text);

    my $path = $_[0];                        # a way to pass a filehandle as an argument
    while (<$path>) {
	chomp($_);                           # rm newlines
	my @words = split(/\pP|\pS|\s/, $_); # extract words
	foreach my $word(@words) {
	    if ($word ne ""){
		$count_words++ ;
		$hash_freq_text{ lc ($word) }++ ;
	    }
	}
    }
    return \%hash_freq_text ;
}

# acquires frequencies computed above
sub txt2hash{
  my $corpus = $_[0] ;
  my %freq;

  open(TXT, '<:utf8', $corpus) ;
  while (<TXT>){
    $_ =~ /(?<word>\S+)\t(?<freq>\S+)\t/ ;
    $freq{ $+{word} } = $+{freq};
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

1; # a perl module must return a true value
