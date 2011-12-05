package Calcul;

use warnings ;
use strict ;

use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");


sub suffix_weight {
    my $gramm_number = $_[2] ; # How many gramms are we looking for ?
    my $k = $_[3] ;
    my %gramm ;
    my $count = 0;

    my $fileHandle = $_[0];

    open(CORPUS, '<:utf8', $_[1]);
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


sub freq {

  # Compute word frequencies
  my %freq ;
  my $count_words = 0 ;                   # total words in file / reinitialize
  my $corpus = $_[1];

  my $fileHandle = $_[0];                 # a way to pass a filehandle as an argument

  open(CORPUS, '<:utf8', $corpus);


  while (<CORPUS>) {
    chomp($_);                          # rm newlines
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
  my %hash;

  my $output = "frequencies/" . lc ($_[0] . "_FREQ");
  open(OUTPUT, '>:utf8', $output);


for (my $i = 0; $i < 10 ; $i++) {
    my @gramm = () ;
    $hash{$sorted[$i]} = $freq{$sorted[$i]}/$count_words*100 ;
    for (my $j = 1; $j < 5; $j++) {
	my @gramm_n = &suffix_weight($fileHandle,$corpus,$j,$i) ;
	@gramm = (@gramm, @gramm_n);	
    }
    print OUTPUT $sorted[$i] . "\t" . $freq{$sorted[$i]}/$count_words*100 . "\t" . join("\t", @gramm) . "\n";
}
  close(CORPUS);
  close(OUTPUT);
}

sub freq_txt {
    my $text ;
    
    my %hash_freq_text ;
    my $count_words ;

    open($_[0], '<:utf8', $text);
    my $fileHandle = $_[0];                 # a way to pass a filehandle as an argument
    
    while (<$fileHandle>) {
	chomp($_);                          # rm newlines
	my @mots = split(/\pP|\pS|\s/, $_); # extract words
	foreach my $mot(@mots) {
	    if ($mot ne ""){
		$count_words++ ;
		$hash_freq_text{ lc ($mot) }++ ;
	    }
	}
    }
    return \%hash_freq_text ;
}




return 1;
