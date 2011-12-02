package MethodeVector;

use warnings ;
use strict ;

use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");



sub txt2hash{
    my $corpus = $_[0] ;
    my %freq;

    open(TXT, '<:utf8', $corpus) ;
    while (<TXT>){
	$_ =~ /(?<mot>\S+)\t(?<freq>\S+)\t/ ;
	$freq{ $+{mot} } = $+{freq};
    }
    close(TXT) ;

    return \%freq ;
}

sub txt2hash_suffix {
    my $corpus = $_[0] ;
    my %freq;
    my %hash_corpus ;

    open(FREQ, '<:utf8', $corpus);
    for (my $n = 1 ; $n < $_[1] ; $n++) {
	while (<FREQ>) {
	    $_ =~ /
	          (:?(:?\S+)\t(:?\S+))  # not match
	          (:?\t(?<gramm>\S+)\t(?<freq>\S+)){$n}
                  /gx ;
	    $hash_corpus{ $+{gramm} } = $+{freq};
	}
    }
 
    close(FREQ);

    return \%hash_corpus ;
}

sub mots {
    my @textes = @{ $_[1] } ;
    my @freq_corpus ;

    my $textes_nbr = scalar(@textes) ;

    for (my $i=0 ; $i <$textes_nbr ; $i++)
    {
	my $file_freq = lc ("frequencies/" . $textes[$i]{fh} . "_freq") ;
	$freq_corpus[$i] = &txt2hash($file_freq) ;
    }

    my $fileHandle = $_[0] ;
    open(TXT, '<:utf8', $fileHandle);

    my $count_words;
    my %txt ;
    while (<TXT>) {
	chomp($_);                          # rm newlines
	my @mots = split(/\pP|\pS|\s/, $_); # extract words
	foreach my $mot(@mots) {
	    if ($mot ne ""){
		$count_words++ ;
		$txt{ lc ($mot) }++ ;
	    }
	}
    }
  
    # sorting hash
    my @sorted = sort { ( $txt{$b} <=> $txt{$a}) or ($a cmp $b) } keys %txt ;
    
# most frequent :
    my %hash;
    for (my $i = 0; $i < 10 ; $i++) {
	$hash{$sorted[$i]} = $txt{$sorted[$i]}/$count_words*100 ;
    }
    
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

    print "La langue du texte d'après l'analyse vectorielle des mots est :\n" ;
    printf "\t" . lc($max_weight) . " (%.2f%%)\n", $results{ $max_weight } ;

}


sub suffixes {
    my $fileHandle = $_[0] ;
    my @textes = @{ $_[1] } ;
    my $n = $_[2] ;
    my $textes_nbr = scalar(@textes) ;
    my %txt ;
    my @freq_corpus ;

    for (my $i=0 ; $i <$textes_nbr ; $i++)
    {
	my $file_freq = lc ("frequencies/" . $textes[$i]{fh} . "_freq") ;
	$freq_corpus[$i] = &txt2hash_suffix($file_freq,$n) ;
    }

# 	while ( ($k,$v) = each %{ $freq_corpus[1] }) {
#  print $k . $v . "\n";   
# }


    open(TXT, '<:utf8', $fileHandle);
    my $count_words = 0;
    while (<TXT>) {
	for (my $i = 1 ; $i < 5 ; $i++) {
	for my $word(split(/\pP|\pS|\s/, $_)){
	    $txt{$+{last}}++ and $count_words++ if $word =~ (/(?<last>.{$i}$)/) ;
	}
	}
    }                         # works


    # sorting hash
    my @sorted = sort { ( $txt{$b} <=> $txt{$a}) or ($a cmp $b) } keys %txt ;
    
# most frequent :
    my %hash;
    for (my $i = 0; $i < 10 ; $i++) {
	$hash{$sorted[$i]} = $txt{$sorted[$i]}/$count_words*100 ;
    }
    
	my %results ;

    for (my $i=0 ; $i < @freq_corpus ; $i++) {
	my ($numerateur, $norme_corpus, $norme_txt, $denominateur, $cos) ;

	while ( my ($k,$v) = each %{ $freq_corpus[$i] }) {
	    $numerateur += $v * $hash{$k} if (exists $hash{$k} ) ;
	    $norme_corpus += $v ** 2 ;
	    $norme_txt += $hash{$k} ** 2 if (exists $hash{$k} ) ;
	}
	$denominateur = ($norme_corpus ** (1/2)) * ($norme_txt ** (1/2)) ;
	
	unless ($denominateur == 0){
	    $cos = $numerateur / $denominateur ;
	    $results{$textes[$i]{fh}} = $cos * 100;
	}
	else {
	    $results{$textes[$i]{fh}} = 0;
	}
    }


    
        my $max_weight = (reverse sort {$results{$a} <=> $results{$b}} keys %results)[0] ;

    print "La langue du texte d'après l'analyse vectorielle des suffixes est :\n" ;
    printf "\t" . lc($max_weight) . " (%.2f%%)\n", $results{ $max_weight } ;

}



return 1 ;
