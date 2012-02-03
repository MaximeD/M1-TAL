#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDIN, "utf8");
binmode(STDOUT, "utf8");
binmode(STDERR, "utf8");

# where the files are
my $dir = "corpustest" ;

# read only txt
my @files = <$dir/*.txt> ;

my %words;

# for each of the files
foreach my $file(@files) {
  # open file (readmode)
  open(INPUT, '<:utf8', $file);

  my $token_counter;
  # read content
  while (<INPUT>) {
    # get token from file
    # it is already tokenized with spaces, so easy to split
    foreach my $token(split(" ", $_)) {
      # create the hash of words that will autoincrement for same words
      $words{ $token }++ ;
      # increment total number of token
      $token_counter++;
    }
  }
  close(INPUT);

  # ok, so the various results are :
  my $total_tokens = $token_counter;
  my $total_words  = keys(%words);
  my $ratio        = $total_tokens / $total_words ;

  # now we create a new file to store the answers
  # new file name is a little modification of input :
  # ie remove the 3 last char (that is "txt")
  # and add the new extension name "freq"
  $file = substr($file, 0, -3) . "freq" ;

  # open that new file for writing
  open(OUTPUT, '>:utf8', $file);
  # and print the results in (tab separated)
  print OUTPUT $total_words . "\t" . $total_tokens . "\t" . $ratio ."\n";
  close(OUTPUT);
}
