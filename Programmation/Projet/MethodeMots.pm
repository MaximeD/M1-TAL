package MethodeMots;

use utf8;
binmode(STDOUT, ":utf8");

##################################
# Do we want to download files ? #
##################################
#
# use LWP::Simple;
#
# sub dwn_file {
# my $url = 'http://www.gutenberg.org/cache/epub/17808/pg17808.txt';
# getstore($url, "corpus/belle-rose.txt");
# }
###############################

my %poids_langues ;

sub poids {

  my %freq ;
  my $count_words = 0 ;                 # total words in file / reinitialize
  
  open($_[0], '<:utf8', $_[1]);
  
  my $fileHandle = $_[0];               # a way to pass a filehandle as an argument
  while (<$fileHandle>) {
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
  my $i ;
  my %hash;
  print "\#\#\#\#\#\#\#\#\#\#\#\#\#\n" ;
  for ($i = 0 ; $i < 10 ; $i++) {
      $hash{$sorted[$i]} = $freq{$sorted[$i]}/$count_words*100 ;
      print "$sorted[$i] \t". $freq{$sorted[$i]}/$count_words*100 . "\n";
  }
  print "sur " . $count_words . " mots\n";
  print "\#\#\#\#\#\#\#\#\#\#\#\#\#\n" ;  
  return %hash ;

}

sub calcul {
  my %hash_corpus = %{$_[1]} ;
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
  return $weight;
}



############
# output ! #
############

sub answer {
    my %results = (
		   french => $_[0],
		   english => $_[1]
		  );

    print "La langue du texte d'après l'analyse des mots est :\n";
    my $max_weight = (reverse sort {$results{$a} <=> $results{$b}} keys %results)[0] ;
    if ($results{$max_weight} !=0) {
      print "\t" . $max_weight . "\n";
    }
    else {
      print "\tINCONNUE\n";
    }
}


1; # a perl module must return true value
