package Answer;

use warnings ;
use strict ;

use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

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

    unless ($total_weight_mot == 0 or $total_weight_suffixes == 0) {
	print "\nCombinaison des résultats...\n" ;
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
    else{
	print "Les résultats ne peuvent pas être combinés\n";	
    }

}

sub vector{
  my %txt = %{ $_[0] } ;
  my $count_words = $_[1];
  my @freq_corpus = @{ $_[2] } ;
  my @textes = @{ $_[3] } ;

  # sorting hash
  my @sorted = sort { ( $txt{$b} <=> $txt{$a}) or ($a cmp $b) } keys %txt ;

  # most frequent :
  my %hash;
  for (my $i = 0; $i < 10 ; $i++) {
    $hash{$sorted[$i]} = $txt{$sorted[$i]}/$count_words*100 ;
  }

  #dot product
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

  my $max_weight = (reverse sort {$results{$a} <=> $results{$b}} keys %results)[0] ;

  # give answer
  print "La langue du texte d'après l'analyse vectorielle des " . $_[4]. " est :\n" ;
  printf "\t" . lc($max_weight) . " (%.2f%%)\n", $results{ $max_weight } ;

}

1; # a perl module must return true value
