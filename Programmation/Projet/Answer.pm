package Answer;

use warnings ;
use strict ;

use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

# compares frequencies, prints highest
sub method_result {
    my %results = %{ $_[1] } ; # hash of word / suffix weights

    # var to get the percentages
    my $total_weight ;
    while ( my ($k,$v) = each %results ) {
	$total_weight += $v ;
    }

    # name of the method used (shift gets the first string argument)
    my $methode = shift ;
    print "La langue du texte d'après l'analyse des $methode est :\n";
    
    # gets highest key
    my $max_weight = (reverse sort {$results{$a} <=> $results{$b}} keys %results)[0] ;
    
    # makes sure there is a valid result, and prints it
    if ($results{$max_weight} != 0) {
	print "\t" . lc($max_weight) ;
	printf(" (%.2f%%)\n", ($results{$max_weight} / $total_weight) * 100);
    }
    else {
      print "\tINCONNUE\n";
    }
}

# compares the results of words and suffixes
sub compare {
    my %results_mots = %{ $_[0] } ;      # values for words
    my %results_suffixes = %{ $_[1] };   # values for suffixes
    
    my %results ;
    my ($total_weight, $total_weight_mot, $total_weight_suffixes);

    # vars to get the percentages
    while ( my ($k,$v) = each %results_mots ) {
	$total_weight_mot += $v ;
	$total_weight_suffixes += $results_suffixes{ $k } ;
    }
    
    # merges results  if the values are valid
    unless ($total_weight_mot == 0 or $total_weight_suffixes == 0) {
	print "\nCombinaison des résultats...\n" ;
	while ( my ($k,$v) = each %results_mots ) {
	    $results{ $k } = (($results_mots{ $k } / $total_weight_mot) + ($results_suffixes{ $k } / $total_weight_suffixes)) * 100 ;
	    $total_weight += $results{ $k } ;
	}
	
	# prints max value of hash wich is the answer
	print "La langue du texte après combinaison est :\n";
	my $max_weight = (reverse sort {$results{$a} <=> $results{$b}} keys %results)[0] ;
	    print "\t" . lc($max_weight) ;
	    printf(" (%.2f%%)\n", ($results{$max_weight} / $total_weight) * 100);
	}
	
    # if no valid values, reports it
    else{
	print "Les résultats ne peuvent pas être combinés\n";	
    }

}

# compares vectors of words
sub vector{
  my %txt = %{ $_[0] } ;              # hash of frequencies of words from file
  my $count_words = $_[1] ;           # total words in file
  my @freq_corpus = @{ $_[2] } ;      # list of vectorial values for the corpus
  my @textes = @{ $_[3] } ;           # list of vectorial values for the file

  # sorts frequencies for file words
  my @sorted = sort { ( $txt{$b} <=> $txt{$a}) or ($a cmp $b) } keys %txt ;

  # gets the n most frequent
  my %hash;
  for (my $i = 0; $i < 10 ; $i++) {
    $hash{$sorted[$i]} = $txt{$sorted[$i]}/$count_words*100 ;
  }

  # does the dot product (see the pdf file for detailed explanations)
  my %results ;
  for (my $i= 0 ; $i < @freq_corpus ; $i++) {
    my ($numerateur, $norme_corpus, $norme_txt, $denominateur, $cos) ;

    while ( my ($k,$v) = each %{ $freq_corpus[$i] }) {
      $numerateur += $v * $hash{$k} if (exists $hash{$k} ) ;
      $norme_corpus += $v ** 2 ;
      $norme_txt += $hash{$k} ** 2 if (exists $hash{$k} ) ;
    }

    if (defined $norme_txt){
      $denominateur = ($norme_corpus ** (1/2)) * ($norme_txt ** (1/2)) ;
      $cos = $numerateur / $denominateur ;
      $results{$textes[$i]{fh}} = $cos * 100;
    }
    else {
      $results{$textes[$i]{fh}} = 0;
    }
  }

  # gets the highest
  my $max_weight = (reverse sort {$results{$a} <=> $results{$b}} keys %results)[0] ;

  # prints answer
  print "La langue du texte d'après l'analyse vectorielle des " . $_[4]. " est :\n" ;
  printf "\t" . lc($max_weight) . " (%.2f%%)\n", $results{ $max_weight } ;

}

1; # a perl module must return a true value
