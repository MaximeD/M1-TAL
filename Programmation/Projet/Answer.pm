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
    my %results_words = %{ $_[0] } ;      # values for words
    my %results_suffixes = %{ $_[1] };   # values for suffixes
    
    my %results ;
    my ($total_weight, $total_weight_word, $total_weight_suffixes);

    # vars to get the percentages
    while ( my ($k,$v) = each %results_words ) {
	$total_weight_word += $v ;
	$total_weight_suffixes += $results_suffixes{ $k } ;
    }
    
    # merges results  if the values are valid
    unless ($total_weight_word == 0 or $total_weight_suffixes == 0) {
	print "\nCombinaison des résultats...\n" ;
	while ( my ($k,$v) = each %results_words ) {
	    $results{ $k } = (($results_words{ $k } / $total_weight_word) + ($results_suffixes{ $k } / $total_weight_suffixes)) * 100 ;
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


1; # a perl module must return a true value
