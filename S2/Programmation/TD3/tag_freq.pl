#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDIN,  'utf8');
binmode(STDOUT, 'utf8');
binmode(STDERR, 'utf8');

=pod

=head1 NAME

I<tag_freq>

Parse a treetagger output to compute the frequency for given tags.

=head1 SYNOPSIS

%tags = &tag_searcher($file,@tags)

=head1 DESCRIPTION

The subroutine I<tag_searcher> returns
a hash where the key is the tag you looked for,
and the value it's frequency.

=cut

# put here the tags you are looking for
# for instance
my @tags = ( "PRO:REL",
	     "PRP:det"
	   );

# the file tagged with treetagger
my $file = "treetagger.txt";

my %tags = &tag_searcher($file,@tags);

# we print ouput to check answers
while (my ($tag, $value) = each %tags) {
  print "$tag :\t$value\n";
}

sub tag_searcher {
  my ($file,@tags) = @_;

  # declare the hash of tags
  # key will be tag
  # and value it's frequency
  my %tags;

  # open file
  open(INPUT, '<', $file);
  while (my $line = <INPUT>) {

    # split the line according to treetagger output
    # columns are tab separated
    my @cols = split("\t", $line);

    # compare cols with tags
    # knowing that the tag is in the second col
    foreach my $tag(@tags) {
      if ($cols[1] eq $tag) {
	$tags{ $tag }++;
      }
    }
  }
  close(INPUT);

  return %tags;
}
