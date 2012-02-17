#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDIN,  'utf8');
binmode(STDOUT, 'utf8');
binmode(STDERR, 'utf8');

=head1 NAME

B<concordancer>

Look for a word and prints the n character on it's side.

=head1 SYNOPSIS

@concordances = &concordancer($file,$word_to_look_for,$side_spread,I<"sort">)



=head1 DESCRIPTION

Give the subroutine the file to parse,
the word you are looking for,
and how many characters should be surrounding your text.

You can also give an optional argument: I<"sort">
which is either "left" or "right"

This optional argument will sort your results on their right or left context.

=cut

# the file you want to analyse
my $file = ("a.txt");

# which word are you looking for?
my $word_to_look_for = "activité";

# how many character on it's side?
my $side_spread = 20;

# do you want a sort ?
# "left" for left sort
# "right" for right sort
# nothing or any other string won't do anything

my @concordances = &concordancer($file,$word_to_look_for,$side_spread,"left");


# print the result, line by line
for (my $i = 0; $i < $#concordances; $i++) {
  print $concordances[$i]{left};
  print "\e[1;34m" ;            # color for a pretty output
  print $word_to_look_for;
  print "\e[0m";                # reset color
  print $concordances[$i]{right};
  print "\n";
}



sub concordancer {
  my ($file,$word_to_look_for,$side_spread,$sort) = @_;

  # the results will be stored in an array of hashes
  # containing left and right contexts
  my @results;

  # open the file
  open(INPUT, '<', $file) or die;

  # read it
  while (my $line = <INPUT>) {
    while ($line =~ m/
		       (?<left>.{0,$side_spread})  # match the left part
		       $word_to_look_for           # match the word
		       (?<right>.{0,$side_spread}) # match the right part
		     /mgx) {

      # results are stored in a hash
      my %concord = (
		     left  => $+{left},
		     right => $+{right}
		    );

      # now we have everything,
      # fill with white spaces to get a pretty aligned output
      if (length($concord{left}) < $side_spread) {
	my $left_missing = $side_spread - length($concord{left}) ;
	$concord{left} = " " x $left_missing . $concord{left};
      }

      # and this hash is added to the results
      push @results, { %concord };
    }

    }
  close(INPUT);


  # the sorting part
  if (defined $sort) {
    # sort left
    if ($sort eq "left") {
      @results = sort{  $$a{"left"} cmp $$b{"left"} } @results;
    }
    # or sort right
    elsif ($sort eq "right") {
      @results = sort{  $$a{"right"} cmp $$b{"right"} } @results;
    }
  }

  return @results;

}
