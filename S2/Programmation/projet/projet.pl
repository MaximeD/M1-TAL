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

print "\n";

my %keyword ;

# parse the keyword list
foreach my $keyword(@keyword_list) {
  # initialize the finding var
  my $found = 0;

  print "Fréquence de \"$keyword\"\n" ;
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
	print "\t" . $doc{ name } . " : " . $keyword{ $doc{ name } } . "\n";
	last;
      }
    }
    close (DOC);
  }

  # the number of texts where it is
  $keyword{ found } = $found;
  print "\t\tTrouvé dans $found textes\n";


  # good,
  # now compute idf
  my $idf;
  if ($keyword{ found } != 0) {
    # compute idf
    $idf = log(abs($D_cardinality) /  $found) ;

    print "\t\tidf: " . $idf . "\n";
  }
  else {
    $idf = "";
  }


  # convert array values
  # to anonymous hashes
  $keyword = {
	     name  => $keyword,
	     found => $found,
	     idf   => $idf
	     } ;
}

print "\n";

# compute the idf
foreach my $keyword(@keyword_list) {
  my %keyword = %$keyword;

  while (my ($k,$v) = each %keyword) {
    print "$k : $v\n";
  }
}
