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
    chomp($_); # rm newlines
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
  print "\n\#\#\#\#\#\#\#\#\#\# OUTPUT Test \#\#\#\#\#\#\#\#\#\#\n";
  print "Les mots les plus fréquents de $_[1] et leurs poids sont :\n";
  my $i ;
  for ($i = 0 ; $i < 10 ; $i++) {
    print "$sorted[$i] \t". $freq{$sorted[$i]}/$count_words*100 . "\n";
  }
  print "\#\#\#\#\#\#\#\#\#\# OUTPUT Test \#\#\#\#\#\#\#\#\#\#\n\n";

  # here comes the nasty stuff :
  # Hash of Hashes !
  # (at first we wanted a variable with a variable name,
  # but that's a bad thing to do according to the internet
  $poids_langues{ $_[0] } = {%freq} ;
}

# files to compare with :

# open(DUTCH, '<:utf8', "corpus/?") ;
# open(ENGLISH, '<:utf8', "corpus/?") ;
# open(FRENCH, '<:utf8', "corpus/belle-rose.txt") ;
# open(GERMAN, '<:utf8', "corpus/?") ;
# open(ITALIAN, '<:utf8', "corpus/?") ;

# &poids(DUTCH) ;
# &poids(ENGLISH) ;
# &poids(FRENCH) ;
# &poids(GERMAN) ;
# &poids(ITALIAN) ;

# close(DUTCH);
# close(ENGLISH);
# close(FRENCH);
# close(GERMAN);
# close(ITALIAN) ;



############
# output ! #
############

sub answer {
  print "La langue du texte d'après l'analyse des mots est :\n"
}


1; # a perl module must return true value
