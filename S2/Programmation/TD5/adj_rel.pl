#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDIN,  'utf8');
binmode(STDERR, 'utf8');
binmode(STDOUT, 'utf8');

=pod

=head1 NAME

B<TreeTagger: Relational adjectives>

List the I<french> relational adjectives
from a treetagger output

=head1 Synopsis

@adj_rel = &search_adj_rel($file)

=cut

# input file
my $file = "treetagger.txt.tag" ;

# call the sub and return a list
my @adj_rel = &search_adj_rel($file);

# print the list
if (scalar(@adj_rel) > 0) {
  print "Les adjectifs relationnels sont les suivants :\n";
  print join(", ", @adj_rel) . "\n";
}


sub search_adj_rel {
  my ($file) = @_ ;
  my @adj_rel;

  open(FILE, '<', $file);
  while(<FILE>) {
    my @line = split(/\t/, $_);
    # math only adjectives
    if ($line[1] eq 'ADJ') {
      # and the one ending with /ique ien al/
      if ($line[0] =~ m/((i(que|en))|al)$/) {
	push @adj_rel, $line[0];
      }
    }
  }
  close(FILE);

  return @adj_rel;
}
