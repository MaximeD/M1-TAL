package Calcul;

use warnings ;
use strict ;

use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

# compute word frequencies
sub freq {
  my %freq ;
  my $count_words = 0 ;                   # total words in file / reinitialize
  my $corpus = $_[0];


  open(CORPUS, '<:utf8', $corpus);

  # create hash of word frequencies
  while (<CORPUS>) {
    chomp($_);                          # rm newlines
    for my $word(split(/\pP|\pS|\s/, $_)) {
      if ($word ne ""){
	$count_words++ ;
	$freq{ lc ($word) }++ ;
      }
    }
  }
  close(CORPUS);

  # transform values in percent
  while (my ($k,$v) = each %freq){
      $freq{$k} = $v / $count_words *100 ;
  }

  # create hash of gramm frequencies
  my @gramms_hash ;

  # create hash of word frequencies
  for (my $i = 1; $i <= $main::gramm_number ; $i++) {
      open(CORPUS, '<:utf8', $corpus);
      my %gramm ;
      my $count_suffixes ;
      while (<CORPUS>) {
	  chomp($_);                              # rm newlines
 	  for my $word(split(/\pP|\pS|\s/, $_)) { # extract words
	      my $tail = substr $word, -$i ;
	      $gramm{$tail}++ and $count_suffixes++ if (length($tail) == $i);
	  }
      }
      # transform values in percent
      while (my ($k,$v) = each %gramm){
	  $gramms_hash[$i]{$k} = $v / $count_suffixes * 100 ;
      }
      close(CORPUS);
  }


  # sort hashes
  my @sorted_words = sort { ( $freq{$b} <=> $freq{$a}) or ($a cmp $b) } keys %freq ;
  my @sorted_gramms ;
  for my $i(1.. $#gramms_hash) {
      for my $key (sort {$gramms_hash[$i]->{$b} <=> $gramms_hash[$i]->{$a} } keys %{$gramms_hash[$i]}) {
	  push @{ $sorted_gramms[$i] }, $key ;
      }
  }


  # write in the file
  open(OUTPUT, '>:utf8', $_[1] );
  for (my $i = 0; $i < $main::max_num ; $i++) {
      if (defined($sorted_words[$i])) {
	  print OUTPUT $sorted_words[$i] . "\t" . $freq{$sorted_words[$i]} ;
      }
      else {
	  print OUTPUT "undef\t0";

      }
      for (my $j = 1; $j <= $main::gramm_number ; $j++) {
	  if (defined($sorted_gramms[$j][$i])) {
	      print OUTPUT "\t" . $sorted_gramms[$j][$i] . "\t" . $gramms_hash[$j]{$sorted_gramms[$j][$i]} ;
	      }
	  else {
	      print OUTPUT "\tundef\t0";
	  }
      }
      print OUTPUT "\n";
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

# acquire word frequencies computed above
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


# acquire suffix frequencies computed above
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
