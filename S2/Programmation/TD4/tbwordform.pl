#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDIN,  'utf8');
binmode(STDOUT, 'utf8');
binmode(STDERR, 'utf8');

=pod

=head1 NAME

B<tbwordform>

Match words with many tags

=head1 Synopsis

&many_tags($file)

=cut

my $file = "tbwordform.txt";

my %word_tags = &many_tags($file);

# some output:

# for the list of words :
print "Les mots suivants ont plusieurs tags :\n";
foreach my $word(keys %word_tags) {
  print $word . " ";
}
print "\n";

# to get tags,
# don't forget $value is a reference to an array
# you will need to dereference it to print content
print "\nVoici leurs étiquettes:\n";
while (my ($word, $tags) = each %word_tags) {
  print $word . ": " . join(", ", @{$tags}) . "\n";
}

sub many_tags {
  my ($file) = @_;

  # the hash where words and tags will be stored
  my %words;

  open(FILE, '<', $file);
  while (<FILE>) {
    my @columns = split("\t", $_);

    # remove line endings
    # chomp won't work because of windows's CRLF...
    $columns[2] =~ s/\r\n//;

    # the value IS a list of tags
      push @{ $words{ $columns[0] } }, $columns[2] ;
    }
  close(FILE);

  my %multitag_words;
  # now work on the hash
  for my $word ( keys %words ) {
    # remove words with only one tag
    if (scalar (@{ $words{$word} }) < 2) {
      delete $words{$word} ;
    }
  }

  return %words;
}
