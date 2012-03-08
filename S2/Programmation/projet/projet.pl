#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDIN, 'utf8');
binmode(STDOUT, 'utf8');
binmode(STDERR, 'utf8');

#############
# main vars #
#############

# the place where the docs are stored
my $path_doc  = "documents/";

# the place where the freqs are stored
my $path_freq = "term_freq/";

# temp wordlist we look for
# will have to be replace by a query
my @keyword_list = qw/la grosse maison jaune dans la verte prairie/;


# get the list of docs to analyse
opendir(DIR, $path_doc);

# the array with the files
my @docs;

foreach my $file (readdir(DIR)) {
  # check it is a text file
  next unless (-f $path_doc . $file);

  # populate the array with informations
  # concerning files
  push @docs, {
	       name 	=> $file,
	       source 	=> $path_doc . $file,
	       output 	=> $path_freq . $file,
	      }
}

closedir(DIR);

# compute the cardinality of the total number of docs in the corpus
my $D_cardinality = scalar(@docs);

# process every doc
for (my $i = 0; $i < @docs; $i++){
  print STDERR "Processing $docs[$i]{ name }...\n";

  my %freq;

  # open doc
  open(DOC, '<', $docs[$i]{ source })
    or die;

  # process doc and populate hash with word frequencies
  while(<DOC>) {
    my @words = split(/\pP|\pS|\s/, $_) ;
    foreach my $word(@words) {
      if ($word ne "") {
	$freq{ lc($word) }++ ;
      }
    }
  }
  close(DOC);

  # sort is optional
  # but it gives a pretty output for the user
  # if you want to look into the freq files
  my @sorted_terms = sort { ( $freq{$b} <=> $freq{$a}) or ($a cmp $b) } keys %freq ;

  # where we write the term frequency
  open(OUTPUT, ">", $docs[$i]{ output });

  for (my $i = 0; $i < @sorted_terms; $i++) {
    print OUTPUT ($sorted_terms[$i] . "\t" . $freq{$sorted_terms[$i]} . "\n");
  }

  close(OUTPUT);
}

my %keyword;

# parse the keyword list
foreach my $keyword(@keyword_list) {

  # initialize the finding var
  my $found = 0;

  # look for the term in every doc
  foreach my $doc(@docs) {
    my %doc = %$doc;

    open (DOC, "<", $doc{ output });
    while (<DOC>){
      my @line_elt = split (/\t/ , $_);

      # if the first column matches the word
      # increment var
      # and put value in hash
      if ($line_elt[0] eq $keyword){
	$found++;
	chomp($line_elt[1]) ;
	$keyword{ $doc{ name } } = $line_elt[1] ;
	last;
      }
    }
    close (DOC);
    $keyword{ $keyword } = $found;
  }
}

foreach my $keyword(@keyword_list) {
  # prevent illegal division by zero
  if ($keyword{ $keyword } != 0) {
    # compute idf
    my $idf = log(abs($D_cardinality) /  $keyword{ $keyword }) ;

    print "$keyword\ta pour idf: " . $idf . "\n";
  }
  else {
    print $keyword . " n'apparaît dans aucun corpus\n";
  }
}


# print "Magic!!!\n";
# foreach my $doc (@docs) {
#   my %doc = %$doc ;
#   while (my ($k, $v) = each %keyword){
#     print "$k\n";
#     if ($v != 0) {
#       my $to_log = abs($D_cardinality) / abs($v);
#       my $result = log($to_log);
#       $keyword{ idf } = $result;
#       print "$doc{ name } tf * idf = " .  $keyword{ $doc{ name } } * $keyword{ idf } . "\n" ;
#       # print $k . "\t a pour idf\t" . $result . "\n";
#     }
#     else {
#       print $k . "\tn'a pas ete trouve\n";
#     }
#   }
# }
