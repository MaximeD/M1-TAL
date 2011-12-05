package MethodeVector;

use warnings ;
use strict ;

use utf8;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

use Answer ;
use Calcul ;

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

  while (<FREQ>) {
      # We get the first good match
      $_ =~ /
	  (:?\S+\t\S+)               # not match
	  (:?\t(?<gramm>\S+)\t(?<freq>\S+))
	/gx  ;
      $hash_corpus{ $+{gramm} } = $+{freq};
      # and now everything that follows
      while ($_ =~ /(:?\t(?<gramm>\S+)\t(?<freq>\S+))/g){
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

  Answer::vector(\%txt,$count_words,\@freq_corpus,\@textes,"mots");
 
}

sub get_gramms {
    my $fileHandle = $_[0];
    open(TXT, '<:utf8', $fileHandle);
    my $count = 0 ;
    my %txt ;
    my %gramm ;
    my $n = $_[1] ;

    while (<TXT>) {
	for my $word(split(/\pP|\pS|\s/, $_)){
	    my $tail = substr $word, -$n ;
	    $gramm{$tail}++ and $count++ if (length($tail) == $n);
	}
    }
      
    my @sorted ;
    @sorted = sort { ( $gramm{$b} <=> $gramm{$a}) or ($a cmp $b) } keys %gramm ;
    for (my $i = 0; $i < 10 ; $i++) {
	$txt{$sorted[$i]} = $gramm{$sorted[$i]}/$count*100 ;
    }
    close(TXT);
    return \%txt ;
  }



sub suffixes {
  my $fileHandle = $_[0] ;
  my @textes = @{ $_[1] } ;
  my $n = $_[2] + 1 ;
  my $textes_nbr = scalar(@textes) ;
  my %txt ;
  my @freq_corpus ;

  for (my $i=0 ; $i <$textes_nbr ; $i++)
    {
      my $file_freq = lc ("frequencies/" . $textes[$i]{fh} . "_freq") ;
      $freq_corpus[$i] = &txt2hash_suffix($file_freq,$n) ;
    }


  for (my $i = 1 ; $i < 5 ; $i++ ) {
      my %gramm ;
      %gramm  = %{ &get_gramms($fileHandle,$i) } ;
      while (my($k,$v) = each %gramm){
	  $txt{$k} =  $v;
      }
  }
 
  #dot product
  my %results ;
  for (my $i= 0 ; $i < @freq_corpus ; $i++) {
    my ($numerateur, $norme_corpus, $norme_txt, $denominateur, $cos) ;

    while ( my ($k,$v) = each %{ $freq_corpus[$i] }) {
      $numerateur += $v * $txt{$k} if (exists $txt{$k} ) ;
      $norme_corpus += $v ** 2 ;
      $norme_txt += $txt{$k} ** 2 if (exists $txt{$k} ) ;
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
  print "La langue du texte d'après l'analyse vectorielle des suffixes est :\n" ;
  printf "\t" . lc($max_weight) . " (%.2f%%)\n", $results{ $max_weight } ;

}



return 1 ;
