package Answer;

use warnings ;
use strict ;

use utf8;
binmode(STDOUT, ":utf8");

sub method_result {
    my %results = %{ $_[1] } ;

    my $total_weight ;
    while ( my ($k,$v) = each %results ) {
	$total_weight += $v ;
    }

    my $methode = shift ;
    print "La langue du texte d'après l'analyse des $methode est :\n";
    my $max_weight = (reverse sort {$results{$a} <=> $results{$b}} keys %results)[0] ;
    if ($results{$max_weight} !=0) {
	print "\t" . lc($max_weight) ;
	printf(" (%.2f%%)\n", ($results{$max_weight} / $total_weight) * 100);
    }
    else {
      print "\tINCONNUE\n";
    }
}

sub compare {
    my %results_mots = %{ $_[0] } ;
    my %results_suffixes = %{ $_[1] };
    my %results ;
    my ($total_weight, $total_weight_mot, $total_weight_suffixes);

    while ( my ($k,$v) = each %results_mots ) {
	$total_weight_mot += $v ;
	$total_weight_suffixes += $results_suffixes{ $k } ;
    }

    while ( my ($k,$v) = each %results_mots ) {
	$results{ $k } = ($results_mots{ $k } / $total_weight_mot) * 100 + ($results_suffixes{ $k } / $total_weight_suffixes) * 100 ;
	$total_weight += $results{ $k } ;
    }
    
    print "La langue du texte après combinaison est :\n";
    my $max_weight = (reverse sort {$results{$a} <=> $results{$b}} keys %results)[0] ;
    if ($results{$max_weight} !=0) {
	print "\t" . lc($max_weight) ;
	printf(" (%.2f%%)\n", ($results{$max_weight} / $total_weight) * 100);
    }
    else {
      print "\tINCONNUE\n";
    }

}

1; # a perl module must return true value
