#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDIN,  'utf8');
binmode(STDOUT, 'utf8');
binmode(STDERR, 'utf8');

# the file you want to analyse
my $file = ("a.txt");
# the file you want to store the results in
my $output = ("b.txt");

# how many maximum token do you want?
my $max_token = 20;

&line_token($file,$output,$max_token);


sub line_token {
  my ($file,$output,$max_token) = @_;

  # open the files
  open(INPUT, '<', $file) or die;
  open(OUTPUT, '>', $output) or die;

  # read it
  while (my $line = <INPUT>) {
    # extract token
    my @token = split(" ", $line);
    # get the number of token
    my $number_of_token = scalar(@token);

    # write line in other file
    # if their are not too many token
    if ($number_of_token <= $max_token) {
      print OUTPUT $line;
    }
  }
  close(INPUT);
  close(OUTPUT);
}
