package Answer;

use utf8;
binmode(STDOUT, ":utf8");

sub method_result {
    my %results = %{ $_[1] } ;

    my $total_weight ;
    while ( ($k,$v) = each %results ) {
	$total_weight += $v ;
    }

    my $methode = shift ;
    print "La langue du texte d'après l'analyse des $methode est :\n";
    my $max_weight = (reverse sort {$results{$a} <=> $results{$b}} keys %results)[0] ;
    if ($results{$max_weight} !=0) {
	print "\t" . lc($max_weight) . "\n";
	printf("Probabilité : %.2f%\n", ($results{$max_weight} / $total_weight) * 100);
    }
    else {
      print "\tINCONNUE\n";
    }
}


1; # a perl module must return true value
