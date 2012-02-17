#!/usr/bin/env perl
use strict;
use warnings;
# use utf8;
# binmode(STDIN,  'utf8');
# binmode(STDOUT, 'utf8');
# binmode(STDERR, 'utf8');

=pod

=head1 NAME

I<tag_match>

Extract words for a given tag

=head1 SYNOPSIS

@words = &tag_match($file,$tag)

=cut

# put here the tag you are looking for
# for instance
my $tag = "P25O75N0";

# the file to look in
my $file = "opinionlastutf8.txt";

my @words = &tag_match($file,$tag);

# print to check answers
print "Les mots suivants on l'étiquette \"$tag\":\n";
print join(", ", @words) . "\n";


sub tag_match {
  my ($file,$tag) = @_;
  my @results ;
  # open file
  open(INPUT, '<', $file);
  while (my $line = <INPUT>) {
    if ($line =~ m/$tag/) {
      $line =~ m/([^,]+)/;
      push(@results, $1);
    }
  }
  close(INPUT);

  return @results;
}
