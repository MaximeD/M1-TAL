package Answer;

use warnings ;
use strict ;

use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

# compare frequencies, print highest
sub method_result {
    my %results = %{ $_[1] } ; # hash of word / suffix weights

    # var to get the percentages
    my $total_weight ;
    while ( my ($k,$v) = each %results ) {
	$total_weight += $v ;
    }

    # name of the method used (shift gets the first string argument)
    my $method = shift ;
    print "According to the $method analysis, the file is in...\n";
    
    # get highest key
    my $max_weight = (reverse sort {$results{$a} <=> $results{$b}} keys %results)[0] ;
    
    # make sure there is a valid result, and print it
    if ($results{$max_weight} != 0) {
	print "\t" . lc($max_weight) ;
	printf(" (%.2f%%)\n", ($results{$max_weight} / $total_weight) * 100);
    }
    else {
      print "\tUNKNOWN\n";
    }
}

# compare the results of words and suffixes
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
    
    # merge results if the values are valid
    unless ($total_weight_word == 0 or $total_weight_suffixes == 0) {
	print "\nMerging results...\n" ;
	while ( my ($k,$v) = each %results_words ) {
	    $results{ $k } = (($results_words{ $k } / $total_weight_word) + ($results_suffixes{ $k } / $total_weight_suffixes)) * 100 ;
	    $total_weight += $results{ $k } ;
	}
	
	# print max value of hash which is the answer
	print "The text is in...\n";
	my $max_weight = (reverse sort {$results{$a} <=> $results{$b}} keys %results)[0] ;
	    print "\t" . lc($max_weight) ;
	    printf(" (%.2f%%)\n", ($results{$max_weight} / $total_weight) * 100);
	}
	
    # if no valid values, report it
    else{
	print "Unable to merge results\n";	
    }

}


1; # a perl module must return a true value
