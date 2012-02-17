#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDIN,  'utf8');
binmode(STDOUT, 'utf8');
binmode(STDERR, 'utf8');

=pod

=head1 NAME

B<line_token>

Compute how many token there are in a line,
if this number is inferior to the one you set,
print the content in another file.

=head1 SYNOPSIS

&line_token($file_to_parse,$output_file,$max_token);

=cut

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
