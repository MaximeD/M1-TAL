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
#   for (my $n = 1 ; $n <= $_[1] ; $n++) {
#     while (<FREQ>) {
#       $_ =~ /
# #	      (:?(:?\S+)\t(:?\S+))  # not match
# 	      (:?(?<gramm>\S+)\t(?<freq>\S+)){$n}
# 	    /gx ;
#       $hash_corpus{ $+{gramm} } = $+{freq};
#     }
#   }


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


  open(TXT, '<:utf8', $fileHandle);

  my ($count_words1, $count_words2, $count_words3, $count_words4) = 0 ;
  my (%txt1, %txt2, %txt3, %txt4) ;
  while (<TXT>) {
      for my $word(split(/\pP|\pS|\s/, $_)){
	  $txt1{$+{last1}}++ and $count_words1++ if $word =~ (/(?<last1>.$)/) ;
	  $txt2{$+{last2}}++ and $count_words2++ if $word =~ (/(?<last2>..$)/) ;
	  $txt3{$+{last3}}++ and $count_words3++ if $word =~ (/(?<last3>...$)/) ;
	  $txt4{$+{last4}}++ and $count_words4++ if $word =~ (/(?<last4>....$)/) ;
      }
  }

  my @sorted ;
  @sorted = sort { ( $txt1{$b} <=> $txt1{$a}) or ($a cmp $b) } keys %txt1 ;
  for (my $i = 0; $i < 10 ; $i++) {
      $txt{$sorted[$i]} = $txt1{$sorted[$i]}/$count_words1*100 ;
  }

  @sorted = sort { ( $txt2{$b} <=> $txt2{$a}) or ($a cmp $b) } keys %txt2 ;
  for (my $i = 0; $i < 10 ; $i++) {
      $txt{$sorted[$i]} = $txt2{$sorted[$i]}/$count_words2*100 ;
  }

  @sorted = sort { ( $txt3{$b} <=> $txt3{$a}) or ($a cmp $b) } keys %txt3 ;
  for (my $i = 0; $i < 10 ; $i++) {
      $txt{$sorted[$i]} = $txt3{$sorted[$i]}/$count_words3*100 ;
  }

  @sorted = sort { ( $txt4{$b} <=> $txt4{$a}) or ($a cmp $b) } keys %txt4 ;
  for (my $i = 0; $i < 10 ; $i++) {
      $txt{$sorted[$i]} = $txt4{$sorted[$i]}/$count_words4*100 ;
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





#  my $count_words = 100 ; # we need to neutralize what comes in the module
#  Answer::vector(\%txt,$count_words,\@freq_corpus,\@textes,"suffixes");

}



return 1 ;
