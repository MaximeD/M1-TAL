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
    my %file = %{$_[0]} ;
    my %french = %{$_[1]} ;
    
    my $total_french = 0 ;
    # compare frequences
    while(($key,$value) = each(%file)){
	if (exists $french{$key}) {
    	    my $result = abs ($value - $french{$key}) ;
    	    $total_french += $result ;
    	}
    	else {
    	    $total_french += $value ;
    	}
    }
    	print $total_french ;
}

sub calcul2 {
    my %file = %{$_[0]} ;
    my %corpus = %{$_[1]} ;

    my $total_corpus = 0 ;
    # compare frequences
    while(($key,$value) = each(%file)){
	if (exists $corpus{$key}) {
    	    $total_corpus += $corpus{$key} ;
    	}
    }
    	return $total_corpus ;
}

sub test {
    my %test = %{$_[0]} ;
    while( my ($k, $v) = each(%test) ) {
        print "key: $k, value: $v.\n";
    }
}

############
# output ! #
############

sub answer {
    my %results = (
	french => $_[0],
	english => $_[1]
	);

    my @sorted = sort { ( $results{$b} <=> $results{$a}) or ($a cmp $b) } keys %results ;

    print "La langue du texte d'après l'analyse des mots est :\n";
    print $sorted[0] . "\n";

}


1; # a perl module must return true value
